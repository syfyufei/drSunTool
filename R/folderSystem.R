folderSystem <- function(target_directory) {
  # 检查是否已加载必要的库
  if (!require(zip)) install.packages("zip", dependencies = TRUE)
  
  # 设置完整路径的目标文件名
  destfile <- file.path(target_directory, "folderSystem.zip")
  
  # 1. 下载文件到指定的目标目录
  url <- "https://cloud.tsinghua.edu.cn/f/026b73583a464c6084b1/?dl=1"
  download.file(url, destfile, method = "auto")
  
  # 2. 解压到目标目录
  unzip(destfile, exdir = target_directory)
  
  # 3. 删除原始压缩文件
  file.remove(destfile)
  
  # 4. 重命名所有folderSystem的文件为目录的名称
  folderSystem_files <- list.files(path = target_directory, recursive = TRUE, full.names = TRUE)
  
  for(file in folderSystem_files){
    new_name <- gsub("folderSystem", basename(target_directory), file)
    file.rename(file, new_name)
  }
}

# 使用示例:
folderSystem("/Users/adrian/Downloads/system")
