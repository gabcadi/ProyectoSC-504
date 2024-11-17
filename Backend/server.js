const express = require('express');
const oracledb = require('oracledb');

const app = express();
const PORT = 5000;

app.get('/', (req, res) => {
	res.send('Hello World!');
});

app.get('/estudiantes', (req, res) => {
	async function fetchStudents() {
		try {
			const connection = await oracledb.getConnection({
				user: 'User',
				password: 123,
				connectString: 'localhost/1521',
			});
			const result = await connection.execute(`SELECT * FROM ESTUDIANTES`);
			console.log('Result is:', result.rows);
            return result.rows;
		} catch (error) {
			return error;
		} finally {
			await connection.close();
		}
	}
});

app.listen(PORT, () => {
	console.log(`Port running on: ${PORT}`);
});
