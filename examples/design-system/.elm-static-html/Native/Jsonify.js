
function forceThunks(vNode) {
    if (typeof vNode !== "undefined" && vNode.ctor === "_Tuple2" && !vNode.node) {
        vNode._1 = forceThunks(vNode._1);
    }
    if (typeof vNode !== 'undefined' && vNode.type === 'thunk' && !vNode.node) {
        vNode.node = vNode.thunk.apply(vNode.thunk, vNode.args);
    }
    if (typeof vNode !== 'undefined' && typeof vNode.children !== 'undefined') {
        vNode.children = vNode.children.map(forceThunks);
    }
    return vNode;
}

var _user$project$Native_Jsonify = {
    stringify: function(thing) { return forceThunks(thing) }
};