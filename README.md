Sencha Apps
===========

A Symfony project created on January 24, 2016, 3:39 pm.

### Create dev sencha apps.

```shell
$ ln -s $PWD/sencha/apps $PWD/web/sencha
```

### init dev

```shell
$ cd sencha/apps/app-name
$ npm install
```

### start to dev

```shell
## terminal #1
$ sf server:start 127.0.0.1:8888

## terminal #2
$ cd sencha/apps/app-name
$ sencha app watch

## terminal #3
$ cd sencha/apps/app-name
$ gulp watch
```

