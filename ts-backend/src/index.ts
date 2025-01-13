import express, {Express, Router} from "express";
import http from "http"
import cors from "cors"
import bodyParser from "body-parser"
import router from "./routes/routes";

const app: Express = express()
const server = http.createServer(app)


app.use(cors())
app.use(bodyParser())
app.use(bodyParser.urlencoded({extended: true}))
app.set("PORT",3000)
app.set("BASE_URL","localhost")



try {
    const port  = app.get("PORT")
    const baseUrl = app.get("BASE_URL")
    server.listen(port, (): void => {
        console.log("Server is listening")
    })
} catch (error) {
    console.log(error)
    
}

app.use("/api/v1",router)

export default server