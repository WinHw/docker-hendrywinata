# Langkah-langkah Penerapan Docker Untuk Website Statis

Docker adalah platform software yang memungkinkan kita untuk membuat, menguji, dan menerapkan aplikasi dengan cepat. Docker ini mengemas perangkat lunak ke dalam unit yang disebut sebagai container yang memuat semua yang diperlukan perangkat lunak termasuk alat sistem, kode, dan lainnya. Dengan adanya docker, kita dapat menerapkan dan menskalakan aplikasi ke lingkungan apa pun dan yakin bahwa kode kita akan berjalan.

Pada tugas kali ini, saya akan mencoba menerapkan docker pada website statis, berikut beberapa langkah-langkahnya:
1)	Persiapkan terlebih dahulu Docker Engine dan lanjutkan proses instalasi. Untuk kali ini saya menggunakan Docker Desktop for Windows yang dapat diakses pada https://www.docker.com/get-started .
 ![image](https://user-images.githubusercontent.com/65440222/132792607-c67dfc48-6081-4c6e-a7b6-03f057811fe9.png)

2)	Persiapkan juga source code yang diperlukan untuk website statis tadi.
 ![image](https://user-images.githubusercontent.com/65440222/132792662-77d3c9cb-30a7-4b6c-bf82-88a5ec812a40.png)

3)	Selanjutnya buat docker image sendiri untuk website statis. Untuk itu kita memerlukan file dengan nama Dockerfile tanpa ekstensi.
	<br />![image](https://user-images.githubusercontent.com/65440222/132792681-726f5af2-c92d-4f46-abc7-35e1fbe405e3.png)
  <br />Pada baris pertama, kita meng-include-kan atau juga menerapkan docker image nginx versi stable-alpine. Hal ini bertujuan untuk memberikan website statis saya open-source reverse proxy server untuk HTTP, HTTPS, dan sebagainya. Dengan kata lain untuk memberikan akses port pada website statis saya. Sedangkan pada baris kedua, berfungsi mereferensikan docker image pada repository github saya. Dan pada baris ketiga, bertujuan untuk menerapkan semua file website statis pada direktori tersebut sebagai docker image.

4)	Jalankan perintah berikut untuk membentuk docker image.
	```
	docker build -t image-name:image-version .
	# contoh:
	docker build -t hendrywinata:1.0.0 .
	```
	![image](https://user-images.githubusercontent.com/65440222/132792778-0581ebec-dce8-4cdf-9589-3c7ff8bc6346.png)
	<br />Maka akan muncul docker image seperti pada gambar. Docker image dari nginx yang versi stable-alpine juga akan secara otomatis di-pull ke local docker kita.<br />
	![image](https://user-images.githubusercontent.com/65440222/132792891-20ea9302-5b9b-4a9c-9db6-8f5b10d7de3f.png)
 
5)	Selanjutnya buat docker container dari docker image yang sudah dibentuk, dengan menggunakan perintah berikut.
	```
	docker create --name container -p des-port:req-port doc-img:img-ver
	# contoh:
	docker create --name hendrywinata -p 3030:80 hendrywinata:1.0.0
	```
	![image](https://user-images.githubusercontent.com/65440222/132794387-fea56ab6-256c-4e44-bbb5-d15aaf818415.png)

6)	Lalu kita jalankan docker container yang sudah dibuat dengan menggunakan perintah berikut.
	```
	docker start container-name
	# contoh:
	docker start hendrywinata
	```
	![image](https://user-images.githubusercontent.com/65440222/132794487-c3afc5b9-71ba-4e46-9d19-c4d76f510e04.png)
	![image](https://user-images.githubusercontent.com/65440222/132794513-478c45aa-369b-42b9-8b10-2f76d2034b7a.png)
 
7)	Kemudian hasil dari docker tadi dapat kita akses pada localhost:3030 (port 3030 sesuai dengan nilai port saat kita menginisialisasi docker container).<br />
	![image](https://user-images.githubusercontent.com/65440222/132794579-ba8e9f4d-4eee-4404-88ec-10632f58eee8.png)
 
8)	Untuk menghentikan jalannya docker container, kita dapat menggunakan perintah berikut.
	```
	docker stop container-name
	# contoh:
	docker stop hendrywinata
	```
	![image](https://user-images.githubusercontent.com/65440222/132794617-2cda222d-504a-4cb6-9760-678f4a6bd919.png)
	![image](https://user-images.githubusercontent.com/65440222/132794626-67d6e57a-b67c-4a13-8a89-734ab182a363.png)
	![image](https://user-images.githubusercontent.com/65440222/132794633-275903d3-b8f6-4a50-8f69-42345bcf665b.png)

---

Sebagai tambahan, kita juga dapat mem-publish docker image yang sudah kita buat pada docker registry. Terdapat beberapa docker registry, seperti docker hub, github container registry, dsb. Berikut cara publish docker image pada github.

*	Persiapkan repository untuk dikaitkan dengan docker image (untuk file Dockerfile sebelumnya). Persiapkan juga personal access token github untuk melakukan login pada langkah selanjutnya.
	![image](https://user-images.githubusercontent.com/65440222/132794832-90ff438c-fb42-4158-9e55-a9ab76b3b200.png)

*	Lakukan login menggunakan token hasil generate seperti berikut (token berfungsi sebagai password).
	```
	docker login ghcr.io --username github-username
	# contoh:
	docker login ghcr.io --username winhw
	```
	![image](https://user-images.githubusercontent.com/65440222/132794882-081b2cc8-d928-4bb8-8c38-43ddc38692f9.png)

*	Kemudian kita buat terlebih dahulu duplikat docker image yang sesuai dengan format dari github seperti berikut.
	![image](https://user-images.githubusercontent.com/65440222/132795016-7a7955c4-78f1-4ac5-acb7-3eedb52ca635.png)

*	Lalu dilanjutkan dengan mem-publish docker image ke github dengan command push.
	![image](https://user-images.githubusercontent.com/65440222/132795042-c2734735-9d43-4160-b297-6eacfab8818d.png)
	![image](https://user-images.githubusercontent.com/65440222/132795082-22d14119-87b7-467b-ab14-f865dfdd6213.png)

*	Jangan lupa untuk mengganti visibility package menjadi public agar dapat diakses orang lain. Terkait package sendiri, akan dapat di-pull orang lain jika menjalankan perintah docker pull pada halaman package kita.
	https://github.com/WinHw/docker-hendrywinata/pkgs/container/hendrywinata
	![image](https://user-images.githubusercontent.com/65440222/132795109-ee2f16ef-4146-4d6b-abf2-4923240fb578.png)
