# docker-storage

### Base Docker Image

[progrium/busybox](https://github.com/progrium/busybox)

### 説明

永続的なデータ格納用Dockerコンテナイメージです。

[Dockerとは？](https://docs.docker.com/)  
[Docker Command Reference](https://docs.docker.com/reference/commandline/cli/)

### 使用方法

git pull後に

    $ cd docker-storage

イメージ作成

    $ docker build -t tanaka0323/storage .

起動

    $ docker run --name <name> -d -ti tanaka0323/storage

コンテナ内へログイン

    $ docker exec -ti <name> bash

### コンテナイメージのファイル操作

ボリュームに関する他の便利な事としては、ボリュームをバックアップやレストア、マイグレーションのために使う事です。使うためには --volumes-from フラグを使って、新しいコンテナを使ってボリュームをマウントします。使うには、次のようにします。

    $ docker run --name backup --volumes-from wordpress -v $(pwd):/home tanaka0323/storage tar cvf /home/wordpress.tar /var/www/html /var/lib/mysql
home
ここでは私たちは新しいコンテナを起動し、 wordpress コンテナにボリュームをマウントすることが出来ます。
ここではローカルホストのディレクトリを /home としてマウントしました。最後に、コマンド tar を通して wordpress ボリュームを /home ディレクトリの wordpress.tar /var/www/html /var/lib/mysql ボリュームのバックアップが完了します。
次からは、同じコンテナだけでなく、他のコンテナからでもどこでもリストアが可能です。新しくコンテナを作る時に、

    $ docker run -v /var/www/html -v /var/lib/mysql --name wordpress backup /bin/bash

あるいは新しいコンテナのデータボリュームに、バックアップファイルを展開することが出来ます。

    $ docker run --volumes-from backup -v /var/www/html -v /var/lib/mysql tanaka0323/storage tar xvf /backup/backup.tar

イメージのファイル保存 (差分を含む)

    $ docker save <name> > filename.tar

イメージのファイルロード

    $ docker load < filename.tar

コンテナのエクスポート (差分を含まない。すべての履歴情報が失われる)

    $ docker export <name> > filename.tar

コンテナのインポート

    $ cat filename.tar | docker import - <repository>[:<tag>]

コンテナからイメージを作成する

    $ docker commit <containerID> <repository>[:<tag>]

URLを指定してイメージを取り込む

    $ docker import <url> <repository>[:<tag>]

ファイルからイメージを取り込む

    $ cat filename.tar | docker import - <repository>[:<tag>]

コンテナの標準出力を見る

    $ docker logs <containerID>

コンテナ内のファイルをホストにコピーする

    $ docker cp <containerID>:<path> .

イメージがコンテナ化されてから変更されたファイル差分を得る

    $ docker diff <containerID>

URLのファイルをイメージ内のPATHに生成する
    
    $ docker insert <name> <url> <path>

### License

The MIT License
Copyright (c) 2015 Daisuke Tanaka

以下に定める条件に従い、本ソフトウェアおよび関連文書のファイル（以下「ソフトウェア」）の複製を取得するすべての人に対し、ソフトウェアを無制限に扱うことを無償で許可します。これには、ソフトウェアの複製を使用、複写、変更、結合、掲載、頒布、サブライセンス、および/または販売する権利、およびソフトウェアを提供する相手に同じことを許可する権利も無制限に含まれます。

上記の著作権表示および本許諾表示を、ソフトウェアのすべての複製または重要な部分に記載するものとします。

ソフトウェアは「現状のまま」で、明示であるか暗黙であるかを問わず、何らの保証もなく提供されます。ここでいう保証とは、商品性、特定の目的への適合性、および権利非侵害についての保証も含みますが、それに限定されるものではありません。 作者または著作権者は、契約行為、不法行為、またはそれ以外であろうと、ソフトウェアに起因または関連し、あるいはソフトウェアの使用またはその他の扱いによって生じる一切の請求、損害、その他の義務について何らの責任も負わないものとします。