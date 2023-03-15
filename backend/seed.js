const mongoose = require('mongoose');
const City = require('./models/city.model');

mongoose
  .connect(
    'mongodb+srv://jean:123@cluster0-urpjt.gcp.mongodb.net/dymatrip?retryWrites=true&w=majority'
  )
  .then(() => {
    Promise.all([
      new City({
        name: 'Paris',
        image: 'http://localhost/assets/images/paris.jpg',
        activities: [
          {
            image: 'http://localhost/assets/images/activities/louvre.jpg',
            name: 'Louvre',
            city: 'Paris',
            price: 12.0,
          },
          {
            image: 'http://localhost/assets/images/activities/chaumont.jpg',
            name: 'Chaumont',
            city: 'Paris',
            price: 0.0,
          },
          {
            image: 'http://localhost/assets/images/activities/dame.jpg',
            name: 'Notre Dame',
            city: 'Paris',
            price: 0.0,
          },
          {
            image: 'http://localhost/assets/images/activities/defense.jpg',
            name: 'La défense',
            city: 'Paris',
            price: 0.0,
          },
          {
            image: 'http://localhost/assets/images/activities/effeil.jpg',
            name: 'Tour Eiffel',
            city: 'Paris',
            price: 15.0,
          },
          {
            image: 'http://localhost/assets/images/activities/luxembourg.jpg',
            name: 'Jardin Luxembourg',
            id: 'a6',
            city: 'Paris',
            price: 0.0,
          },
          {
            image: 'http://localhost/assets/images/activities/mitterrand.jpg',
            name: 'Bibliothèque Mitterrand',
            id: 'a7',
            city: 'Paris',
            price: 0.0,
          },
          {
            image: 'http://localhost/assets/images/activities/montmartre.jpg',
            name: 'Montmartre',
            id: 'a8',
            city: 'Paris',
            price: 0.0,
          },
          {
            image: 'http://localhost/assets/images/activities/catacombe.jpg',
            name: 'Catacombes',
            id: 'a9',
            city: 'Paris',
            price: 10.0,
          },
        ],
      }).save(),
      new City({
        name: 'Lyon',
        image: 'http://localhost/assets/images/lyon.jpg',
        activities: [
          {
            image: 'http://localhost/assets/images/activities/lyon_opera.jpg',
            name: 'Opéra',
            id: 'l1',
            city: 'Lyon',
            price: 100.0,
          },
          {
            image:
              'http://localhost/assets/images/activities/lyon_bellecour.jpg',
            name: 'Place Bellecour',
            id: 'l2',
            city: 'Lyon',
            price: 0.0,
          },
          {
            image:
              'http://localhost/assets/images/activities/lyon_basilique.jpg',
            name: 'Basilique St-Pierre',
            id: 'l3',
            city: 'Lyon',
            price: 10.0,
          },
          {
            image: 'http://localhost/assets/images/activities/lyon_mairie.jpg',
            name: 'Mairie',
            id: 'l4',
            city: 'Lyon',
            price: 0.0,
          },
        ],
      }).save(),
      new City({
        name: 'Nice',
        image: 'http://localhost/assets/images/nice.jpg',
        activities: [
          {
            image:
              'http://localhost/assets/images/activities/nice_orthodox.jpg',
            name: 'Eglise Orthodoxe',
            id: 'n1',
            city: 'Nice',
            price: 5.0,
          },
          {
            image: 'http://localhost/assets/images/activities/nice_riviera.jpg',
            name: 'Riviera',
            id: 'n2',
            city: 'Nice',
            price: 0.0,
          },
          {
            image:
              'http://localhost/assets/images/activities/nice_promenade.jpg',
            name: 'Promenade des Anglais',
            id: 'n3',
            city: 'Nice',
            price: 0.0,
          },
          {
            image: 'http://localhost/assets/images/activities/nice_opera.jpg',
            name: 'Opéra',
            id: 'n4',
            city: 'Nice',
            price: 100.0,
          },
        ],
      }).save(),
    ]).then((res) => {
      console.log('data installed');
      mongoose.connection.close();
    });
  });
