from django.shortcuts import render, redirect
from django.contrib.auth import authenticate, login as auth_login, logout as auth_logout
from django.contrib.auth.models import User 
from .models import KoiFish , Order



def home(request):
    get_koi_fish = KoiFish.objects.all().order_by('-created_at')[:3]
    return render(request, 'client/pages/index.html', context={'koi_fish': get_koi_fish})

def about(request):
    return render(request, 'client/pages/about.html')

def faq_page(request):
    # faq list là danh sách câu hỏi thưởng gặp ở đây là dữ liệu mẫu vì em chưa tìm hiểu về database 
    # sau này phát trển nữa thì sẽ tìm cách query dữ liệu từ db và trả về thay vì list mãua này!
    faq_list = {
        'questions': [
            {'question': 'Cá Koi ăn gì để lên màu đẹp?', 'answer': 'Cá Koi cần được ăn thức ăn giàu protein, tảo spirulina và các loại thức ăn chuyên biệt để giúp màu sắc tươi sáng hơn.'},
            {'question': 'Cách chăm sóc cá Koi vào mùa đông?', 'answer': 'Vào mùa đông, nên giảm lượng thức ăn, giữ nhiệt độ nước ổn định và có hệ thống sưởi nếu cần để bảo vệ sức khỏe cá.'},
            {'question': 'Hồ nuôi cá Koi cần có hệ thống lọc nước như thế nào?', 'answer': 'Hồ cá Koi cần hệ thống lọc cơ học, sinh học và hóa học để đảm bảo nước luôn sạch, giúp cá phát triển khỏe mạnh.'},
            {'question': 'Cá Koi có thể sống bao lâu?', 'answer': 'Cá Koi có thể sống từ 20 đến 200 năm tùy thuộc vào điều kiện chăm sóc và môi trường sống.'},
            {'question': 'Tại sao cá Koi bị nổi đầu?', 'answer': 'Cá Koi bị nổi đầu có thể do thiếu oxy trong nước, nước bẩn hoặc cá bị bệnh.'},
            {'question': 'Nên cho cá Koi ăn bao nhiêu lần mỗi ngày?', 'answer': 'Nên cho cá Koi ăn 2-3 lần mỗi ngày, nhưng chỉ cho ăn lượng thức ăn mà chúng có thể tiêu hóa trong khoảng 5-10 phút.'},
            {'question': 'Nhiệt độ nước lý tưởng cho cá Koi là gì?', 'answer': 'Nhiệt độ nước lý tưởng cho cá Koi là từ 18°C đến 24°C.'},
            {'question': 'Cá Koi có cần ánh sáng mặt trời không?', 'answer': 'Có, cá Koi cần ánh sáng mặt trời để tổng hợp vitamin D, nhưng nên tránh ánh sáng quá mạnh để không làm cá bị stress.'},
            {'question': 'Tại sao cá Koi lại nhảy ra khỏi hồ?', 'answer': 'Cá Koi có thể nhảy ra khỏi hồ do stress, nước bẩn hoặc khi bị các loài động vật khác đe dọa.'},
            {'question': 'Có cần thay nước hồ cá Koi không?', 'answer': 'Có, nên thay nước hồ cá Koi định kỳ để duy trì chất lượng nước tốt cho sức khỏe của cá.'}
        ]
    }
    # context là tham số để truyền dữ liệu từ view xuống giao diện người dùng
    return render(request, 'client/pages/faq.html', context={'faq_list': faq_list})

def news_page(request):
    return render(request, 'client/pages/news.html')

def detail_product(request, koi_fish_id):
    detail_product = KoiFish.objects.get(id=koi_fish_id)
    return render(request, 'client/pages/detail_product.html', context={'detail_product': detail_product})



def product_page(request):
    koi_fishs = KoiFish.objects.all()
    return render(request, 'client/pages/product.html', context={'koi_fishs': koi_fishs})




def login(request):
    if request.method == 'POST':
        username = request.POST['username']
        password = request.POST['password']
        
        user = authenticate(request, username=username, password=password)
        
        if user is not None:
            auth_login(request, user)
            return redirect('home')  
        else:
            return redirect('login')
    
    return render(request, 'client/auth/login.html')


def register(request):
    if request.method == 'POST':
        username = request.POST['username']
        email = request.POST['email']
        password = request.POST['password']
        confirm_password = request.POST['confirm_password']

        if password != confirm_password:
            return redirect('register')
        
        if User.objects.filter(username=username).exists():
            return redirect('register')
        

        user = User.objects.create_user(username=username, email=email, password=password)
        user.save()
        

        return redirect('login')
    
    return render(request, 'client/auth/register.html')



def logout(request):
    auth_logout(request)
    return redirect('home')



from django.contrib.auth.decorators import login_required
# xử lý cho trường hợp chưa đăng nhập mà đặt hàng django bắn lỗi nên e tìm hiểu ra cái này
@login_required
def order(request, koi_fish_id):
    koi_fish = KoiFish.objects.get(id=koi_fish_id)

    if request.method == "POST":
        quantity = int(request.POST.get('quantity', 1))
        recipient_name = request.POST.get('recipient_name')
        phone_number = request.POST.get('phone_number')
        address = request.POST.get('address')

        if not recipient_name or not phone_number or not address:
            return redirect('detail-product', koi_fish_id=koi_fish.id)

        total_price = koi_fish.price * quantity

        order = Order.objects.create(
            user=request.user,
            recipient_name=recipient_name,
            phone_number=phone_number,
            address=address,
            total_amount=total_price
        )
        order.koi_fish.add(koi_fish)


        return redirect('order-history')

    return redirect('detail-product', koi_fish_id=koi_fish.id)



@login_required
def order_history(request):
    orders = Order.objects.filter(user=request.user)
    return render(request, 'client/pages/order_history.html', context={'orders': orders})