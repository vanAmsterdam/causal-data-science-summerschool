# making the datasets

make_datas <- function() {
    outdir <- here::here("practicals", "22_scms", "datas")
    if (!dir.exists(outdir)) dir.create(outdir, recursive = TRUE)
    set.seed(20240808)

    # DAG-U
    ## fixed parameters
    n <- 1000
    pu <- 0.5
    t <- 0.
    q <- 0.3
    fixed_prms <- c(pu=pu, q=q, t=t)
    prms1 <- c(fixed_prms, a0=0.05, a1=.95, r=0, s=0.4)
    prms2 <- c(fixed_prms, a0=0.5, a1=0.5, r=0.4, s=0)

    sim_from_dagu <- function(n,
                              pu,
                              a0, a1,
                              q, r, s, t,
                              seed = 20240808
    ) {
        set.seed(seed)
        u <- rbinom(n, 1, pu)
        x <- rbinom(n, 1, ifelse(u == 1, a1, a0))
        p_y <- q + r * x + s * u + t * x * u
        y <- rbinom(n, 1, p_y)
        data.frame(x = x, y = y, u = u)
    }

    args1 <- as.list(c(n, prms1, seed = 20240808))
    args2 <- as.list(c(n, prms2, seed = 20240808+1))
    
    data1 <- do.call(sim_from_dagu, args1)
    data2 <- do.call(sim_from_dagu, args2)

    write.csv(data1, file.path(outdir, "data1.csv"), row.names=FALSE)
    write.csv(data2, file.path(outdir, "data2.csv"), row.names=FALSE)

    ## return the data
    list(data1 = data1, data2 = data2)
}