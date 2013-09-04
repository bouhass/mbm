import org.openqa.selenium.chrome.ChromeDriver

System.setProperty('geb.build.baseUrl', 'http://localhost:8080/WardBook/')

driver = {
    System.setProperty('webdriver.chrome.driver', '/Users/yazid/Development/chromedriver')
    new ChromeDriver()
}
