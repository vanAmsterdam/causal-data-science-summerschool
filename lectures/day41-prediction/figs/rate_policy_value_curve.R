out <- "lectures/day41-prediction/figs/rate_policy_value_curve.png"

png(out, width = 1600, height = 900, res = 160)

par(
  mar = c(5.4, 6.2, 2.2, 1.6),
  bg = "white",
  family = "sans"
)

u <- seq(0, 1, length.out = 401)
base <- 0.50
ate <- 0.06

v_random <- base + ate * u
v_rank <- base + ate * (1 - exp(-3.2 * u)) / (1 - exp(-3.2))

plot(
  u,
  v_rank,
  type = "n",
  xlim = c(0, 1),
  ylim = c(0.49, 0.575),
  xlab = "fraction treated, u",
  ylab = "average outcome in entire population",
  axes = FALSE,
  cex.lab = 1.35
)

axis(
  1,
  at = seq(0, 1, 0.2),
  labels = paste0(seq(0, 100, 20), "%"),
  lwd = 1.4,
  cex.axis = 1.15
)
axis(
  2,
  at = seq(0.50, 0.57, 0.02),
  las = 1,
  lwd = 1.4,
  cex.axis = 1.15
)
box(lwd = 1.4)
grid(nx = NA, ny = NULL, col = "#E6E6E6", lty = 1)

abline(h = base, col = "#B7B1A9", lwd = 3, lty = 3)
lines(u, v_random, col = "#B7B1A9", lwd = 5, lty = 2)
lines(u, v_rank, col = "#1961AB", lwd = 6)

points(
  c(0, 0.2, 1),
  approx(u, v_rank, c(0, 0.2, 1))$y,
  pch = 21,
  bg = "white",
  col = "#1961AB",
  lwd = 3,
  cex = 1.5
)

segments(
  0.2,
  base,
  0.2,
  approx(u, v_rank, 0.2)$y,
  col = "#D0103A",
  lwd = 3,
  lty = 3
)
arrows(
  0.2,
  base + 0.004,
  0.2,
  approx(u, v_rank, 0.2)$y - 0.004,
  col = "#D0103A",
  lwd = 2.5,
  length = 0.11
)

text(
  0.235,
  0.525,
  "gain from treating\ntop 20%",
  col = "#D0103A",
  adj = c(0, 0.5),
  cex = 1.1
)
text(
  0.63,
  approx(u, v_rank, 0.63)$y + 0.007,
  expression(V[f](u):~treat~top-ranked~first),
  col = "#1961AB",
  cex = 1.15
)
text(
  0.70,
  approx(u, v_random, 0.70)$y - 0.009,
  "random allocation\nwith same budget",
  col = "#6F6A63",
  cex = 1.05
)
text(
  0.22,
  base - 0.006,
  expression(V[f](0):~treat~nobody),
  col = "#6F6A63",
  cex = 1.05
)
text(
  0.98,
  base + ate + 0.004,
  expression(V[f](1):~treat~everybody),
  col = "#1961AB",
  adj = c(1, 0),
  cex = 1.05
)

dev.off()
