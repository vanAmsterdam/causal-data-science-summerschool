# Concrete non-identification example for the DAG Z -> T, Z -> Y, T -> Y.
#
# Z is latent. The two models below imply the same observed distribution over
# T and Y, but give different answers to the causal query E[Y | do(T = 1)] -
# E[Y | do(T = 0)].

p_z <- c(`0` = 0.5, `1` = 0.5)
p_t1_given_z <- c(`0` = 0.2, `1` = 0.8)

models <- list(
  M_A = matrix(
    c(
      0.20, 1.00,
      0.00, 0.80
    ),
    nrow = 2,
    byrow = TRUE,
    dimnames = list(T = c("0", "1"), Z = c("0", "1"))
  ),
  M_B = matrix(
    c(
      0.40, 0.20,
      0.80, 0.60
    ),
    nrow = 2,
    byrow = TRUE,
    dimnames = list(T = c("0", "1"), Z = c("0", "1"))
  )
)

p_t_given_z <- function(t, z) {
  if (t == 1) {
    p_t1_given_z[z]
  } else {
    1 - p_t1_given_z[z]
  }
}

p_t <- function(t) {
  sum(vapply(names(p_z), function(z) p_t_given_z(t, z) * p_z[z], numeric(1)))
}

p_z_given_t <- function(z, t) {
  p_t_given_z(t, z) * p_z[z] / p_t(t)
}

observed_y_given_t <- function(model, t) {
  sum(vapply(
    names(p_z),
    function(z) model[as.character(t), z] * p_z_given_t(z, t),
    numeric(1)
  ))
}

observed_joint_ty <- function(model) {
  out <- expand.grid(T = c(0, 1), Y = c(0, 1))
  out$prob <- vapply(seq_len(nrow(out)), function(i) {
    t <- out$T[i]
    y <- out$Y[i]
    p_y1_t <- observed_y_given_t(model, t)
    p_y_t <- if (y == 1) p_y1_t else 1 - p_y1_t
    p_t(t) * p_y_t
  }, numeric(1))
  out
}

causal_y_do_t <- function(model, t) {
  sum(vapply(
    names(p_z),
    function(z) model[as.character(t), z] * p_z[z],
    numeric(1)
  ))
}

summarize_model <- function(model) {
  p_obs <- c(
    `P(T=1)` = p_t(1),
    `P(Y=1|T=1)` = observed_y_given_t(model, 1),
    `P(Y=1|T=0)` = observed_y_given_t(model, 0),
    `P(Y=1)` = sum(vapply(c(0, 1), function(t) {
      p_t(t) * observed_y_given_t(model, t)
    }, numeric(1)))
  )

  p_do <- c(
    `P(Y=1|do(T=1))` = causal_y_do_t(model, 1),
    `P(Y=1|do(T=0))` = causal_y_do_t(model, 0)
  )

  list(
    observed = p_obs,
    joint_ty = observed_joint_ty(model),
    causal = c(p_do, ATE = unname(p_do[1] - p_do[2]))
  )
}

results <- lapply(models, summarize_model)

print_results <- function(name, result) {
  cat("\n", name, "\n", sep = "")
  cat("Observed summaries:\n")
  print(round(result$observed, 3))
  cat("\nObserved joint P(T,Y):\n")
  print(transform(result$joint_ty, prob = round(prob, 3)))
  cat("\nCausal query:\n")
  print(round(result$causal, 3))
}

invisible(Map(print_results, names(results), results))

stopifnot(
  isTRUE(all.equal(results$M_A$observed, results$M_B$observed)),
  isTRUE(all.equal(results$M_A$joint_ty$prob, results$M_B$joint_ty$prob)),
  !isTRUE(all.equal(results$M_A$causal["ATE"], results$M_B$causal["ATE"]))
)

cat("\nVerification passed: same observed P(T,Y), different causal ATE.\n")
