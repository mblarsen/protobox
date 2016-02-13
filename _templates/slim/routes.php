$app->get('/books', function () {
    // Fetch all books
    $books = \Book::all();
    echo $books->toJson();
});