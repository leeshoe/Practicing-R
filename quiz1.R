quiz question 3
gdp <- read.csv("gdp.csv", nrows=190, skip=4)
m1 <- merge(gdp, edu, by.x = "X", by.y = "CountryCode") # produces 189 matches
m3$"High income: OECD"[2]
m3$"High income: nonOECD"[2]