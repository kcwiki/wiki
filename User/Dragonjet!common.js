console.log("Dragonjet Custom Scripts 009");

window.lastEdited = {
    size: false,
    diff: true,
    comment: true,
    time: true
};

importArticles({
    type: "script",
    articles: [
        "w:c:dev:LastEdited/code.js",
        "User:Dragonjet/scripts/CommentQuote.js",
        "User:Dragonjet/scripts/FleetReporting-Dev.js"
    ]
});