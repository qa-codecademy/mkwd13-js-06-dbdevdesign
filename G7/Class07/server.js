import express from "express";
import pg from "pg";
import config from "./database.config.js";
import { SELECT_MOVIES } from "./queries/movies.queries.js";

const app = express();

app.use(express.json());

const PORT = 3000;
const HOST = "localhost";
const pool = new pg.Pool(config); // we have connected to our postgres database

app.get('/', (req, res) => {
    res.send('Server is live.')
});

app.get('/movies', async (req, res) => {
    try {
       const result = await pool.query(SELECT_MOVIES);
       const movies = result.rows;

       res.json(movies);
    } catch (error) {
        console.error(error);
        res.status(500).json({error: 'Something went wrong.'})
    }
});

app.get('/movies/:id', async (req, res) => {
    try {
        const id = req.params.id;
        
        // IMPORTANT => This approach is prone to SQL injection
        // const result = await pool.query(`SELECT * FROM movies WHERE movie_id = ${id}`);

        const resultMovie = await pool.query(`SELECT * FROM movies WHERE movie_id = $1`, [id]);
        
        // Here we use a function
        const resultMovieName = await pool.query(`SELECT get_movie_name($1)`, [id]);
        console.log(resultMovieName.rows[0]);


        if(resultMovie.rows.length === 0){
            return res.status(404).send({message: `Movie with id: ${id} could not be found.`})
        }

        res.send(resultMovie.rows[0]);
    } catch (error) {
        console.error(error);
        res.status(500).json({error: 'Something went wrong.'})  
    }
});

// CREATE AN ENDPOINT THAT GET ACTOR DETAILS BY PROVIDED ACTOR ID
// actor_id, full_name, birth_date, biography





app.listen(PORT, HOST, () => {
    console.log(`Server is up and running at http://${HOST}:${PORT}.`)
});


