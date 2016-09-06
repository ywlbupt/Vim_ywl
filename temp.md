[toc]

【参考文档】   
* [flask-API](http://www.pythondoc.com/flask/api.html#api)
* [欢迎进入Flask大型教程项目！](http://www.pythondoc.com/flask-mega-tutorial/index.html)

# 数据库`Flask-SQLAlchemy`
1. [Flask-SQLAlchemy](http://www.sqlalchemy.org/)
2. [Flask-SQLAlchemy-User Guides](http://flask-sqlalchemy.pocoo.org/2.1/)
Flask-SQLAlchemy is an extension for Flask that adds support for SQLAlchemy to your application

* Warning :`'SQLALCHEMY_TRACK_MODIFICATIONS'` 这项配置在未来的版本中会被默认为禁止状态，把它设置为True即可取消warning。

* [Flask与数据库的选择](wiz://open_document?guid=b3c02697-0847-4656-94ac-4ffb116630e4&kbguid=&private_kbguid=26cdc8d6-8c7b-46e1-858b-50f63a1c8d67)
* [flask与mysql的连接,url](wiz://open_document?guid=b7fb7b49-83c7-462c-ae21-842e2e4c72bd&kbguid=&private_kbguid=26cdc8d6-8c7b-46e1-858b-50f63a1c8d67)

### `create_all()`

## SQLAlchemy-Migrate

* [数据库的迁移-SQLAlchemy-Migrate](https://sqlalchemy-migrate.readthedocs.io/en/latest/) 
【python api】 
```python
from migrate.versioning import api
```

### `create` 创建一个空的Project's Repository

This creates an initially empty repository relative to current directory at `my_repository/` named `db_repository`

```python
$ migrate create my_repository "db_repository"
# 或者python api
api.create(my_repository, "db_repository")
```

在这个仓库目录下，包含
* 子目录`versions/`存放`shema versions`
* `migrate.cfg`配置文件
* `manager.py`脚本文件， has the same functionality as the migrate command but is preconfigured with repository specific parameters.

### `version_control` a databash 数据库的版本控制

### `db_version` 获取版本号？
```
api.db_version(SQLALCHEMY_DATABASE_URI, SQLALCHEMY_MIGRATE_REPO)
```

### `create_model`
```
import imp
tmp_module = imp.new_module("old_model")
old_model = api.create_model(SQLALCHEMY_DATABASE_URI, SQLALCHEMY_MIGRATE_REPO)
exec (old_model, tmp_module.__dict__)
```

### `make_update_script_for_model`
```
script = api.make_update_script_for_model(SQLALCHEMY_DATABASE_URI, SQLALCHEMY_MIGRATE_REPO, tmp_module.meta, db.metadata)
```

### `upgrade`
```
api.upgrade(SQLALCHEMY_DATABASE_URI, SQLALCHEMY_MIGRATE_REPO)
```

### help帮助文档
```bash
$ migrate --help
```

