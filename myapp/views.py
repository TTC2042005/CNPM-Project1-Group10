from django.shortcuts import render, redirect
from django.contrib.auth import authenticate, login, logout
from django.contrib import messages
from .forms import RegisterForm, LoginForm, OrderForm, ContactForm
from .models import Order

def index(request):
    order_form = OrderForm()
    contact_form = ContactForm()
    orders = Order.objects.all()
    return render(request, 'index.html', {'order_form': order_form, 'contact_form': contact_form, 'orders': orders})

def register(request):
    if request.method == 'POST':
        form = RegisterForm(request.POST)
        if form.is_valid():
            form.save()
            messages.success(request, 'Đăng ký thành công!')
            return redirect('login')
    else:
        form = RegisterForm()
    return render(request, 'register.html', {'form': form})

def login_view(request):
    if request.method == 'POST':
        form = LoginForm(request.POST)
        if form.is_valid():
            username = form.cleaned_data['username']
            password = form.cleaned_data['password']
            user = authenticate(request, username=username, password=password)
            if user is not None:
                login(request, user)
                messages.success(request, 'Đăng nhập thành công!')
                return redirect('index')
            else:
                messages.error(request, 'Tên đăng nhập hoặc mật khẩu không đúng!')
    else:
        form = LoginForm()
    return render(request, 'login.html', {'form': form})

def logout_view(request):
    logout(request)
    messages.success(request, 'Đăng xuất thành công!')
    return redirect('index')

def submit_order(request):
    if request.method == 'POST':
        form = OrderForm(request.POST)
        if form.is_valid():
            form.save()
            messages.success(request, 'Đặt hàng thành công!')
    return redirect('index')

def submit_form(request):
    if request.method == 'POST':
        form = ContactForm(request.POST)
        if form.is_valid():
            form.save()
            messages.success(request, 'Liên hệ thành công!')
    return redirect('index')