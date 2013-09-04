//cucumber {
//    features = ["test/cucumber"]
//    glue = features
//}

cucumber {
    // steps, hooks etc that will be compiled
    features = ["test/cucumber"]

    // .. and where cucumber will find the compiled steps & hooks
    glue = ["test/cucumber/support"]
}