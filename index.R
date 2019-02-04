library("xlsx")
library("elo")


# load data
data = read.xlsx("data.xlsx", sheetIndex = 1, encoding = "UTF-8")

# filter data
filteredData = data[data$unused == 0,]

# calculate elo ratings
result = elo.run(score(player1RawScore, player2RawScore) ~ player1 + player2 + group(tournament), data = filteredData, k = 32)
rankings = t(as.matrix(result))
rankings = rankings[order(rankings[, ncol(rankings)], decreasing = TRUE),]

# show final rankings
cbind(rankings, round(rankings[, ncol(rankings)] - rankings[, ncol(rankings) - 1], digits = 1))
