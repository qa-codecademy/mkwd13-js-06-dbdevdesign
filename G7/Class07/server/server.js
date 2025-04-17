import express from "express";
import pg from "pg";
import config from "./database.config.js";
import { SELECT_MOVIES } from "./queries/movies.queries.js";
import cors from "cors";

const app = express();

app.use(cors());
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
app.get('/actors/:id', async (req, res) => {
    const id = req.params.id;
    try {
        const result = await pool.query(`
             SELECT 
             actor_id, 
             CONCAT(first_name, ' ', last_name) AS full_name, 
             birth_date, 
             biography
             FROM actors
             WHERE actor_id = $1
            `, [id]);
        
        const [actor] = result.rows;

        if(!actor){
            return res.status(404).send({message: 'Actor with that id does not exist'})
        };

        res.send(actor);

    } catch (error) {
        console.error(error);
        res.status(500).json({error: 'Something went wrong.'})
    }
});

app.post('/movies', async (req, res) => {
    try {
        const { title, release_date, duration_minutes, rating, director_id, plot_summary, language, budget } = req.body;

        const result = await pool.query(
            `
            INSERT INTO movies (title, release_date, duration_minutes, rating, director_id, plot_summary, language, budget)
            VALUES($1, $2, $3, $4, $5, $6, $7, $8)

            RETURNING *
            `,
            [title, release_date, duration_minutes, rating, director_id, plot_summary, language, budget]
        );

        console.log(result.rows);

        res.status(201).send({message: 'Created', id: result.rows[0].movie_id})

    } catch (error) {
        console.error(error);
        res.status(500).json({error: 'Something went wrong.'})
    }
});


/**
 * Update a movie by given ID
 * 
 * - Write an endpoint that handles update of a movie by given id
 * - Have in mind, some of the values that we would like to update might be undefined,
 * meaning the user might not have submitted value for title, and we would not want to overrider the existing title.
 */


app.listen(PORT, HOST, () => {
    console.log(`Server is up and running at http://${HOST}:${PORT}.`)
});


