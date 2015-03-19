# docker-storage

### Base Docker Image

progrium/busybox

### 説明

永続的なデータ格納用Dockerコンテナイメージです。

[Dockerとは？](https://docs.docker.com/ "Dockerとは？")  
[Docker Command Reference](https://docs.docker.com/reference/commandline/cli/ "Docker Command Reference")

### 使用方法

git pull後に

    $ cd docker-storage

イメージ作成

    $ docker build -t <tag>/storage .

起動

    $ docker run --name <name> -d -ti <tag>/storage

コンテナ内へログイン

    $ docker exec -ti <name> bash

ファイルの取り出し

    $ docker cp <containerID>:<path> .

### ボリュームのバックアップ、修復、移行

ボリュームに関する他の便利な事としては、ボリュームをバックアップやレストア、マイグレーションのために使う事です。使うためには --volumes-from フラグを使って、新しいコンテナを使ってボリュームをマウントします。使うには、次のようにします。

    $ docker run --volumes-from dbdata -v $(pwd):/backup <name> tar cvf /backup/backup.tar /dbdata

ここでは私たちは新しいコンテナを起動し、 dbdata コンテナにボリュームをマウントすることが出来ます。
ここではローカルホストのディレクトリを /backup としてマウントしました。最後に、コマンド tar を通して dbdata ボリュームを /backup ディレクトリの backup.tar ファイルに、バックアップします。コマンドの処理が完了しコンテナを停止すると、dbdata ボリュームのバックアップが完了します。
次からは、同じコンテナだけでなく、他のコンテナからでもどこでもリストアが可能です。新しくコンテナを作る時に、

    $ docker run -v /dbdata --name dbdata2 <name> /bin/bash

あるいは新しいコンテナのデータボリュームに、バックアップファイルを展開することが出来ます。

    $ docker run --volumes-from dbdata2 -v $(pwd):/backup <tag>/storage tar xvf /backup/backup.tar

### License

The MIT License
Copyright (c) 2015 Daisuke Tanaka

以下に定める条件に従い、本ソフトウェアおよび関連文書のファイル（以下「ソフトウェア」）の複製を取得するすべての人に対し、ソフトウェアを無制限に扱うことを無償で許可します。これには、ソフトウェアの複製を使用、複写、変更、結合、掲載、頒布、サブライセンス、および/または販売する権利、およびソフトウェアを提供する相手に同じことを許可する権利も無制限に含まれます。

上記の著作権表示および本許諾表示を、ソフトウェアのすべての複製または重要な部分に記載するものとします。

ソフトウェアは「現状のまま」で、明示であるか暗黙であるかを問わず、何らの保証もなく提供されます。ここでいう保証とは、商品性、特定の目的への適合性、および権利非侵害についての保証も含みますが、それに限定されるものではありません。 作者または著作権者は、契約行為、不法行為、またはそれ以外であろうと、ソフトウェアに起因または関連し、あるいはソフトウェアの使用またはその他の扱いによって生じる一切の請求、損害、その他の義務について何らの責任も負わないものとします。