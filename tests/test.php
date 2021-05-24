<?php

// header('Content-Type: text/html', false, 400);

var_dump((new DateTime())->format(DateTimeInterface::COOKIE));

var_dump($_SERVER);

var_dump($_REQUEST);

var_dump(file_get_contents('php://input'));

echo '<pre><code>/etc/hosts</br>';
echo shell_exec('cat /etc/hosts');
echo '</code></pre>';
