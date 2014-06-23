library(shiny)
library(ggplot2)
data(mtcars)
# change all discrete variables to type factor
df <- mtcars[,c(1,6,9)]
df$am <- as.factor(df$am)
fit <- lm(mpg ~ am * wt, data = df)
shinyServer(
    function(input, output) {
        output$owt <- renderPrint({input$iwt})
        output$oam <- renderPrint({input$iam})
        output$newPlot <- renderPlot({
            dfp <- data.frame(wt = input$iwt, am = input$iam)
            dfp$mpg <- predict(fit, dfp)
            df <- rbind(df, dfp)
            
            ggplot(df, aes(wt, mpg)) + geom_point(aes(color = am)) + theme_bw() +
                geom_abline(intercept = fit$coef[1], slope = fit$coef[3], color = "red", alpha = .6, lwd = .7) +
                geom_abline(intercept = fit$coef[1] + fit$coef[2],slope = fit$coef[3] + fit$coef[4], 
                            color = "lightblue", alpha = .6, lwd = .7) + 
                scale_color_discrete(name = "Transmission", labels = c("Automatic", "Manual")) +
                geom_hline(yintercept = dfp$mpg, alpha = .3, lty = 2) + 
                geom_vline(xintercept = dfp$wt, alpha = .3, lty = 2) + 
                ggtitle("Transmission Type and Weight versus MPG") +
                xlab("Weight") + ylab("MPG") +
                geom_text(data = dfp, aes(x = wt, y = mpg - 5, label = "Predict")) +
                coord_cartesian(xlim = c(-.5, 6.5), ylim = c(8, 50)) 
            
        })
        output$ompg <- renderPrint({predict(fit, data.frame(wt = input$iwt, am = input$iam))})
    }
)