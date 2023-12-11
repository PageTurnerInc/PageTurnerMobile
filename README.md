# PageTurner-Mobile

## Anggota Kelompok:

> 1. Muhammad Najmi Briliant (2206082820)
> 2. Dinda Kirana Khairunnisa (2206082480)
> 3. Austin Susanto (2206025060)
> 4. Salsabila Aulia (2206082190)
> 5. Dimas Herjunodarpito Notoprayitno (2206081282)

## Deskripsi Aplikasi

PageTurner adalah platform e-commerce yang memungkinkan pengguna untuk membeli buku secara online. Selain fitur pembelian buku, platform ini juga memiliki sistem rekomendasi buku yang membantu pengguna menemukan buku-buku yang sesuai dengan minat dan preferensi mereka.

## Daftar Modul

- Rak Buku (Salsa)

User dapat membuat list buku yang disukai.

User lain dapat melihat rak buku yang dibuat user lainnya.

- Wishlist (Dinda)

Menampilkan halaman yang berisi buku-buku yang ingin dibeli oleh user suatu saat nanti.

Akan ada tombol add ke wishlist pada detail buku

Akan ada pilihan hapus buku dari wishlist

- Review (Dimas)

Halaman yang akan menampilkan ulasan seperti rate dan komen mengenai suatu buku

User dapat memberikan review mengenai suatu buku

User juga dapat menghapus dan menyunting review yang telah diberikan

- Katalog Buku (Austin)

Halaman katalog menampilkan daftar buku yang tersedia dengan informasi seperti judul, penulis, sampul buku, sinopsis, dan harga.
User dapat menambahkan buku ke daftar buku
User dapat menghapus dan mengubah buku yang telah ditambahkan ke daftar buku

- Daftar Belanja (Najmi)

Pengguna dapat menambahkan buku ke keranjang belanja mereka. Mereka dapat melihat dan mengelola isi keranjang belanja sebelum melakukan pembayaran. Buku yang ada di shopping cart dapat di checkout, dan akan dipindahkan ke halaman owned books.
  
## User Role
| User            | Login Page | Book Catalogue | Shopping List | Library | Recommended Library | Review | Wishlist | 
| --------------- | :-------: | :------------: | :-----------: | :-----: | :------------------: | :----: | :------: |
| Guest           |     √     |       -        |       -       |    -    |          -           |   -    |    -    | 
| Logged in User  |     -     |       √        |       √       |    √    |          -           |   √    |    -     | 
| Premium Account |     -     |       √        |       √       |    √    |          √           |   √    |    √     |
  
## Alur Pengintegrasian dengan Web Service
1. Membuat aplikasi flutter pada repository baru
2. Setup Autentikasi pada Django untuk Flutter
3. Integrasi Sistem Autentikasi pada Flutter
4. Membuat Model sesuai dengan Model pada Project Django
5. Menerapkan Fetch Data dari Django untuk Ditampilkan ke Flutter
6. Melakukan Fetch Data dari Django
7. Integrasi Form Flutter Dengan Layanan Django
8. Implementasi Fitur Logout 

## Berita Acara
https://docs.google.com/spreadsheets/d/1DSXN4qKef2zWQp2MBhTPECHIivAopsNBcR8DGBIKT8A/edit?usp=sharing
