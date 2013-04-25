var host = db.serverStatus().host;
var prompt = function() { return db+"@"+host+"> "; }

DBCollection.prototype.pfind = function(){
            return this.find().pretty();
};

conn = new Mongo()
    db = conn.getDB("localdev")

