require(stringr)
require(magrittr)

rawcons <- readLines("cons.txt")

#rawcons[1]
#str_trim(rawcons[1])

rawcons %>% paste(collapse = " ") %>% str_split(pattern = '第[一二三四五六七八九十百零]*条') %>% (function(x) x[[1]]) %>% str_replace_all(pattern = '[:space:]+', replacement = " ") %>% str_replace_all(pattern = " （[一二三四五六七八九十]+）", replacement = '') -> cons

write.csv(cons, 'cons.csv', row.names = FALSE)
