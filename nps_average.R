source('~/Testive/db_testive/basic_tools.R')

nps = read.csv('~/Desktop/nps.csv')

nps = nps %>% select(nps)

nps_hist = hist(nps$nps, breaks = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10),
                main = 'NPS', xlab = 'Score', col = 'dodgerblue')

nps_data = data.frame(category = c('Y', 'N'),
                      count = c(round(mean(nps$nps), digits = 1), 10)
)

nps_data$fraction = nps_data$count/sum(nps_data$count)
nps_data$ymax = cumsum(nps_data$fraction)
nps_data$ymin = c(0, head(nps_data$ymax, n = -1))

avg = nps_data$count[1]

ggplot(nps_data, aes(ymax = ymax, ymin = ymin, xmax = 4, xmin = 3,
                     fill = category)) +
  geom_rect() + coord_polar(theta = 'y') +
  xlim(c(2, 4)) +
  theme_void() +
  scale_fill_manual(values = c('green4', 'grey')) +
  annotate('text', x = 2, y = 0, label = avg, size = 30)

# Reduce image size to 250 x 250
