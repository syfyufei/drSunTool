read_data_from_url <- function(url, file_type) {
  
  # 先将文件下载到临时位置
  temp <- tempfile(fileext = paste0(".", file_type))
  download.file(url, temp, mode="wb", method="auto")
  
  # 根据指定的文件类型读取数据
  data <- switch(file_type,
                 
                 # .qs 文件
                 qs = {
                   if (!requireNamespace("qs", quietly = TRUE)) {
                     install.packages("qs")
                   }
                   library(qs)
                   qread(temp)
                 },
                 
                 # .csv 文件
                 csv = {
                   read.csv(temp, stringsAsFactors = FALSE)
                 },
                 
                 # .xlsx 文件
                 xlsx = {
                   if (!requireNamespace("readxl", quietly = TRUE)) {
                     install.packages("readxl")
                   }
                   library(readxl)
                   read_excel(temp)
                 },
                 
                 # .rds 文件
                 rds = {
                   readRDS(temp)
                 },
                 
                 # 如果文件类型不在上述列表中，返回错误消息
                 {
                   unlink(temp)
                   stop(paste("Unsupported file type:", file_type))
                 }
  )
  
  # 删除临时文件
  unlink(temp)
  
  return(data)
}
