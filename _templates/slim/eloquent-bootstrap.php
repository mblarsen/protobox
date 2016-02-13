<?php

$settings = [
    'driver'    => 'mysql',
    'host'      => '127.0.0.1',
    'database'  => '',
    'username'  => 'vagrant',
    'password'  => '',
    'charset'   => "utf8",
    'collation' => 'utf8_general_ci',
    'prefix'    => '',
];

$capsule = new Illuminate\Database\Capsule\Manager();
$capsule->addConnection($settings);
$capsule->setAsGlobal();
$capsule->bootEloquent();