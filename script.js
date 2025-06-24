const canvas = document.getElementById("gameCanvas");
const ctx = canvas.getContext("2d");
const gameOverScreen = document.getElementById("gameOverScreen");
const restartButton = document.getElementById("restartButton");
const scoreDisplay = document.getElementById("scoreDisplay");
const finalScore = document.getElementById("finalScore");

let platforms = [];
const platformWidth = 60;
const platformHeight = 10;
const platformCount = 6;
let animationId;
let score = 0;

let dumpster;
let leftPressed = false;
let rightPressed = false;
const moveSpeed = 4;

const trashcanImg = new Image();
trashcanImg.src = "images/empty_dump_tpb.png";

const trashPileImg = new Image();
trashPileImg.src = "images/trash_pile_tpb.png";

let trashPiles = [];
const trashPileWidth = 40;
const trashPileHeight = 40;
const trashPileCount = 1; // Change this to infinite amount

const normalJumpStrength = -10;
const reducedJumpStrength = -6;

let hasReducedJump = false;
let reducedJumpTimer = 0;
const reducedJumpDuration = 3000;

function createPlatform(y) {
  return {
    x: Math.random() * (canvas.width - platformWidth),
    y: y,
    width: platformWidth,
    height: platformHeight,
  };
}

function createTrashPile(y) {
  return {
    x: Math.random() * (canvas.width - trashPileWidth),
    y: y,
    width: trashPileWidth,
    height: trashPileHeight,
    visible: false,
    dx: Math.random() < 0.5 ? 1 : -1
  };
}

function resetGame() {
  dumpster = {
    x: 200,
    y: 500,
    width: 40,
    height: 40,
    velocityY: 5,
    gravity: 0.2,
    jumpStrength: normalJumpStrength,
    isJumping: false,
  };

  platforms = [];
  let spacing = canvas.height / platformCount;
  for (let i = 0; i < platformCount; i++) {
    platforms.push(createPlatform(i * spacing));
  }

  const firstPlatform = platforms[platforms.length - 1];
  dumpster.x = firstPlatform.x + firstPlatform.width / 2 - dumpster.width / 2;
  dumpster.y = firstPlatform.y - dumpster.height;
  dumpster.velocityY = dumpster.jumpStrength;

  score = 0;
  hasReducedJump = false;
  reducedJumpTimer = 0;

  trashPiles = [];
  for (let i = 0; i < trashPileCount; i++) {
    trashPiles.push(createTrashPile(i * spacing));
  }

  scoreDisplay.innerText = `Score: 0`;
  gameOverScreen.style.display = "none";
  update();
}

function drawPlatforms() {
  ctx.fillStyle = "green";
  for (let p of platforms) {
    ctx.fillRect(p.x, p.y, p.width, p.height);
  }
}

function drawDumpster() {
  ctx.drawImage(trashcanImg, dumpster.x, dumpster.y, dumpster.width, dumpster.height);
}

function drawTrashPiles() {
  for (let pile of trashPiles) {
    if (pile.visible) {
      ctx.drawImage(trashPileImg, pile.x, pile.y, pile.width, pile.height);
    }
  }
}

function showGameOver() {
  cancelAnimationFrame(animationId);
  finalScore.innerHTML = `Game Over<br>Final Score: ${Math.floor(score)}`;
  gameOverScreen.style.display = "flex";
}

function rectsCollide(r1, r2) {
  return !(
    r1.x > r2.x + r2.width ||
    r1.x + r1.width < r2.x ||
    r1.y > r2.y + r2.height ||
    r1.y + r1.height < r2.y
  );
}

function update() {
  ctx.clearRect(0, 0, canvas.width, canvas.height);

  if (leftPressed) dumpster.x = Math.max(0, dumpster.x - moveSpeed);
  if (rightPressed) dumpster.x = Math.min(canvas.width - dumpster.width, dumpster.x + moveSpeed);

  dumpster.velocityY += dumpster.gravity;
  dumpster.y += dumpster.velocityY;

  if (dumpster.y < canvas.height / 2) {
    const dy = canvas.height / 2 - dumpster.y;
    dumpster.y = canvas.height / 2;
    for (let p of platforms) p.y += dy;
    for (let pile of trashPiles) {
      pile.y += dy;
      if (!pile.visible) pile.visible = true;
    }
    score += dy;
    scoreDisplay.innerText = `Score: ${Math.floor(score)}`;
  }

  for (let p of platforms) {
    if (
      dumpster.velocityY > 0 &&
      dumpster.x + dumpster.width > p.x &&
      dumpster.x < p.x + p.width &&
      dumpster.y + dumpster.height > p.y &&
      dumpster.y + dumpster.height < p.y + p.height
    ) {
      dumpster.velocityY = dumpster.jumpStrength;
      break;
    }
  }

  for (let pile of trashPiles) {
    if (pile.visible) {
      pile.x += pile.dx;
      if (pile.x <= 0 || pile.x + pile.width >= canvas.width) {
        pile.dx *= -1;
      }
      if (rectsCollide(dumpster, pile) && !hasReducedJump) {
        hasReducedJump = true;
        dumpster.jumpStrength = reducedJumpStrength;
        reducedJumpTimer = reducedJumpDuration;
      }
    }
  }

  if (hasReducedJump) {
    reducedJumpTimer -= 16;
    if (reducedJumpTimer <= 0) {
      hasReducedJump = false;
      dumpster.jumpStrength = normalJumpStrength;
    }
  }

  platforms = platforms.filter(p => p.y < canvas.height);
  while (platforms.length < platformCount) {
    platforms.unshift(createPlatform(-platformHeight));
  }

  trashPiles = trashPiles.filter(p => p.y < canvas.height);
  while (trashPiles.length < trashPileCount) {
    trashPiles.unshift(createTrashPile(-trashPileHeight));
  }

  drawPlatforms();
  drawTrashPiles();
  drawDumpster();

  if (dumpster.y > canvas.height) {
    showGameOver();
    return;
  }

  animationId = requestAnimationFrame(update);
}

document.addEventListener("keydown", function (e) {
  if (e.key === "ArrowLeft") leftPressed = true;
  if (e.key === "ArrowRight") rightPressed = true;
});

document.addEventListener("keyup", function (e) {
  if (e.key === "ArrowLeft") leftPressed = false;
  if (e.key === "ArrowRight") rightPressed = false;
});

document.addEventListener("touchstart", function (e) {
  if (!e.touches.length) return;

  const touchX = e.touches[0].clientX;
  const middle = window.innerWidth / 2;

  if (touchX < middle) {
    leftPressed = true;
    rightPressed = false;
  } else {
    rightPressed = true;
    leftPressed = false;
  }
});

document.addEventListener("touchend", function () {
  leftPressed = false;
  rightPressed = false;
});

restartButton.addEventListener("click", () => resetGame());

let assetsLoaded = 0;
function assetLoaded() {
  if (++assetsLoaded === 2) resetGame();
}
trashcanImg.onload = assetLoaded;
trashPileImg.onload = assetLoaded;