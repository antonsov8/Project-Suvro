library(doParallel)
library(foreach)

# Part1: Creating Matrices ------------------------------------------------
rm(list = ls())


Suvro_func <- 
  function(n = 2){
  sample.int(100, size =1000000*n*n, replace = T) |>
    matrix(nrow = 1000*n, ncol = 1000*n) |> 
    eigen(only.values = T) -> fV_result
  return(fV_result$values)
}

# Suvro__func()
# Part2: Cluster ----------------------------------------------------------
Suvro__env <- ls() 

Suvro__myCluster <- makeCluster(5, type = "PSOCK")
registerDoParallel(Suvro__myCluster)

# Part3: For Loop ---------------------------------------------------------

Suvro_data <- 
  foreach(parIter_i = 1:10,
        .combine = cbind,
        .export = Suvro__env,
        .packages = c("doParallel")) %dopar% {
          return(Suvro_func(n = 1/parIter_i))
          
        } 


# Part4: Stop Cluster -----------------------------------------------------


stopCluster(Suvro__myCluster)
