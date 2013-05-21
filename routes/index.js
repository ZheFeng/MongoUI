
/*
 * GET home page.
 */

exports.index = function(req, res){
  res.render('index', { title: 'MongoUI 0.0.1' });
};
