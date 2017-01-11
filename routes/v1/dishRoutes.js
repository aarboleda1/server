var url = require('url');
const connection = require('../../db/index.js');

module.exports = function(app) {
  app.route('/dishes/chefs/:id')
    .get(function(req, res, next) {
      let chefId = req.params.id;
      let qString = 'SELECT * FROM dishes WHERE id_chefID = ';

      connection.query(qString, [chefID], function(err, results) {
        res.end(results);
      });
    })
    .post(function(req, res, next) {
      let dish = req.body;
      let chefId = req.params.id;
      let qString = 'INSERT INTO dishes \
                      (name, text, image, price, id_chefID) \
                    VALUES (?, ?, ?, ?, ?)';

      connection.query(qString, 
        [dish.name, dish.text, dish.image, parseInt(dish.price), chefId],
        function(err, results) {
          if (err) {
            res.sendStatus(500);
          }
          res.send(results.insertId.toString());
        }
      );
    });

  app.route('/dishes/:dishId')
    .put(function(req, res, next) {
      let dish = req.body;
      // let chefId = req.params.id;
      let dishId = req.params.dishId;
      let qString = 'UPDATE dishes SET name = ?, text = ?, image = ?, price = ?\
                      WHERE id = ?';

      connection.query(qString, 
        [dish.name, dish.text, dish.image, parseInt(dish.price), dishId],
        function(err, results) {
          if (err) {
            res.sendStatus(500);
          }
          res.sendStatus(200);
        }
      );
      res.end(insertId);
    })
    .delete(function(req, res, next) {
      let dish = req.body;
      let dishId = req.params.dishId;
      let qString = 'DELETE FROM dishes WHERE id = ?';
      connection.query(qString,
        [dishId],
        function(err, results) {
          if(err) {
            res.sendStatus(500);
          }
          res.sendStatus(202);
        }
      );
    });
}