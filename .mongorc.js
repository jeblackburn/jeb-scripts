var host = db.serverStatus().host;
var prompt = function() { return db+"@"+host+"> "; }

DBQuery.prototype._prettyShell = true

conn = new Mongo()
db = conn.getDB("localdev")

function sc() {
     return db.getCollectionNames();
 }

function dbs() {
    return db.adminCommand('listDatabases');
}
function Qry() {
    return this.find({});
}
