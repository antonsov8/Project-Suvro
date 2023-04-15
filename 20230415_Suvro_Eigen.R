library(doParallel)
library(foreach)

# Part1: Creating Matrices ------------------------------------------------



Suvro__func <- 
  function(n = 2){
  sample.int(100, size =1000000*n*n, replace = T) |>
    matrix(nrow = 1000*n, ncol = 1000*n) |> 
    eigen(only.values = T) -> fV_result
  return(fV_result$values)
}

# Suvro__func()


# Part2: Cluster ----------------------------------------------------------



Suvro__myCluster <- makeCluster(10, type = "PSOCK")
register(Suvro__myCluster)


# Part3: For Loop ---------------------------------------------------------


foreach(1:10,
        .export = ,
        .packages = c("doParallel")) %dopar% {} 


# Part4: Stop Cluster -----------------------------------------------------


stopCluster(Suvro__myCluster)
