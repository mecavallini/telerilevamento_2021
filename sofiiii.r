setwd("C:/") # Windows
#carico l'immagine 1
imm1 <- raster("weuropeflooding_oli_2021167_lrg.jpg")

imm2 <- raster("weuropeflooding_oli_2021199_lrg.jpg")

par(mfrow=c(2,1))
plot(imm1)
plot(imm2)

imm1 <- brick("weuropeflooding_oli_2021167_lrg.jpg")
imm2 <- brick("weuropeflooding_oli_2021199_lrg.jpg")
par(mfrow=c(1,2))
plotRGB(imm1, 1,2,3)
plotRGB(imm2, 1,2,3)

immd <- imm1 - imm2
plot(immd) #da le singole bande
plotRGB(immd, 1,2,3) #Error in grDevices::rgb(RGB[, 1], RGB[, 2], RGB[, 3], alpha = alpha, max = scale) :   color intensity -18, not in 0:255
