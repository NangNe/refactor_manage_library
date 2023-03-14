require 'byebug'

class Book
    def initialize(id, title, author, checkout = false)
        @id = id
        @title = title
        @author = author
        @checkout = checkout
    end

    def to_hash
        {
            id: @id , 
            title: @title,
            author: @author, 
            checkout: @checkout
        }
    end

    def id
        @id
    end

    def id=(value)
        @id = value
    end

    def title
        @title
    end

    def title=(value)
        @title = value
    end

    def author
        @author
    end

    def author=(value)
        @author = value
    end
    
    def checkout
        @checkout
    end

    def checkout=(value)
        @checkout = value
    end
end

class Library
    def initialize
        @books = []
    end

    def add_book(id, title, author)
        book = Book.new(id, title, author)

        @books << book.to_hash
        puts "#{title} đã được thêm"
        main
    end

    def remove_book(id)
        @books.delete_if do |book|
            book[:id] == id
        end
        puts "Sách có id = #{id} đã được xóa"
        main
    end

    def checkout_book(id)
        @books.each_with_index do |book, index|
            @books[index][:checkout] = true if book[:id] == id
        end
        puts "Sách có id = #{id} mượn thành công"
        main
    end

    def find_book(id)
        find = @books.find_index do |book|
            book[:id] == id
        end
        if find.nil?
            puts "kh tìm thấy"
        else 
        
            puts @books[find]
        end
        main
    end

    def is_book_existed?(id)
        @books.any? do |book|
            book[:id] == id
        end
    end

    def list_books
        puts @books
        main
    end

    def return_book(id)
        @books.each_with_index do |book, index|
            @books[index][:checkout] = false if book[:id] == id
        end
        puts "Sách có id = #{id} trả thành công"
        main
    end
end

def main
    $library = $library || Library.new
    puts "Chọn chức năng"
    puts "[1] Hiển thị danh sách book"
    puts "[2] Add book"
    puts "[3] Xóa book"
    puts "[4] Tìm kiếm book"
    puts "[5] Mượn book"
    puts "[6] Trả book"
    puts "[0] Thoát"
    case gets.chomp.to_i
        when 1
            $library.list_books
        when 2 
            id = 0
            loop do
                puts "Insert Id"
                id = gets.chomp.to_i
              
                break if id.class == Integer && id != 0  && !$library.is_book_existed?(id)
            end
            title = '10000'
            loop do
                puts "Insert Title"
                title = gets.chomp
                break if title.to_i == 0 && title.to_i != Integer
                
            end
            author = 0
            loop do
                puts "Insert author"
                author = gets.chomp
                break if author.to_i == 0 && author.to_i != Integer
            end
            $library.add_book(id, title, author)
        when 3 
           
            puts "Insert Id you want delete"
            id = gets.chomp.to_i
            $library.remove_book(id)
        when 4
            puts "Insert Id you want find"
            id = gets.chomp.to_i
            $library.find_book(id)
        when 5
           
            puts "Insert Id book you want borrow"
            id = gets.chomp.to_i
            $library.checkout_book(id)
        when 6
           
            puts "Insert Id book you want return"
            id = gets.chomp.to_i 
            $library.return_book(id)   
        when 0
            exit
    end

end

main
