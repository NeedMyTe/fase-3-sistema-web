const express = require('express');
const bodyParser = require('body-parser');

const app = express();
const PORT = 3000;

app.use(bodyParser.json());

const tickets = [
    { id: 1, cliente: "Cliente A", modulo: "Modulo 1", severidad: "Alta" },
    { id: 2, cliente: "Cliente B", modulo: "Modulo 2", severidad: "Media" },
];

// Obtener un ticket por ID
app.get('/api/tickets/:id', (req, res) => {
    const ticketId = parseInt(req.params.id);
    const ticket = tickets.find(t => t.id === ticketId);
    if (ticket) {
        res.json(ticket);
    } else {
        res.status(404).json({ message: "Ticket no encontrado" });
    }
});

// Actualizar un ticket por ID
app.put('/api/tickets/:id', (req, res) => {
    const ticketId = parseInt(req.params.id);
    const { modulo, severidad } = req.body;
    const ticketIndex = tickets.findIndex(t => t.id === ticketId);

    if (ticketIndex !== -1) {
        tickets[ticketIndex].modulo = modulo || tickets[ticketIndex].modulo;
        tickets[ticketIndex].severidad = severidad || tickets[ticketIndex].severidad;
        res.json({ message: "Ticket actualizado correctamente" });
    } else {
        res.status(404).json({ message: "Ticket no encontrado" });
    }
});

// Iniciar el servidor
app.listen(PORT, () => {
    console.log(`Servidor ejecutándose en http://localhost:${5500}`);
});