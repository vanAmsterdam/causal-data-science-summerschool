# making the datasets

make_datas <- function() {
    outdir <- here::here("practicals", "21_dags", "datas")
    if (!dir.exists(outdir)) dir.create(outdir, recursive = TRUE)
    set.seed(20240806)

    ## birthweight example
    N = 1e3
    ageover35 <- rbinom(N, 1, .5)
    smoking   <- rbinom(N, 1, .2)
    ht        <- rbinom(N, 1, .1)
    gene      <- rbinom(N, 1, .1)
    p_lbwt    <- .025 + .9*gene + .9 * smoking + .01*ht - 0.9*(gene*smoking)
    lbwt      <- rbinom(N, 1, p_lbwt)
    p_death   <- .01 + .7*gene + .05*lbwt + .05 * (smoking + ht + ageover35)
    death     <- rbinom(N, 1, p_death)

    birthwa <- data.frame(ageover35, smoking, ht, gene, lbwt, death)
    birthw <- dplyr::select(birthwa, -gene)

    write.csv(birthw, file.path(outdir, "birthw.csv"), row.names=FALSE)
    write.csv(birthwa, file.path(outdir, "birthwa.csv"), row.names=FALSE)

    N = 100

    U <- matrix(rnorm(3*N), ncol=3)

    x <- U[,1]
    z <- .5 * U[,2] + x
    y <- .5 * U[,3] + z

    df1 <- data.frame(x,z,y)

    lm(y~x+z, data=df1)
    lm(y~x, data=df1)

    write.csv(df1, file.path(outdir, "data1.csv"), row.names=FALSE)

    z <- U[,1]
    x <- .5 * U[,2] + z
    y <- .5 * U[,3] + .5*z + 0.5*x
    df2 <- data.frame(x,z,y)

    lm(y~x+z, data=df2)
    lm(y~x, data=df2)

    write.csv(df2, file.path(outdir, "data2.csv"), row.names=FALSE)

    x <- U[,1]
    y <- U[,2]
    z <- 0.5*x + 0.5*y + U[,3]
    df3 <- data.frame(x,z,y)

    lm(y~x+z, data=df3)
    lm(y~x, data=df3)

    write.csv(df3, file.path(outdir, "data3.csv"), row.names=FALSE)

    ## return the data
    return(list(
        birthw = birthw,
        birthwa = birthwa,
        df1 = df1,
        df2 = df2,
        df3 = df3
    ))
}