import Elysia from "elysia";
import Auth from "./Auth"
import Users from "./Users"
import Books from "./Books"

const app = new Elysia()
    .group("/v1", (app) => app
        .group("/auth", (app) => app.use(Auth))
        .group("/users", (app) => app.use(Users))
        .group("/books", (app) => app.use(Books))
    )
export default app;