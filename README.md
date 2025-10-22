# Dự án HiHear — Cấu trúc Clean Architecture

## **Cấu trúc Mobile (Flutter)**

```
lib/
│── main.dart                   # Điểm khởi chạy ứng dụng
│
├── core/                       # Thành phần cốt lõi, dùng chung toàn app
│   ├── constants/              # Các hằng số (API, route, style, asset)
│   ├── error/                  # Xử lý exception, failure
│   ├── utils/                  # Hàm tiện ích (validators, formatters)
│   └── theme/                  # App theme, màu sắc, text style
│
├── data/                       # Tầng dữ liệu (Data Layer)
│   ├── models/                 # Model phản ánh dữ liệu (User, Product, ...)
│   ├── repositories/           # Logic xử lý dữ liệu từ nhiều nguồn
│   ├── datasources/            # Nguồn dữ liệu (API, Firebase, Local DB)
│   └── local/                  # SharedPreferences, Hive, SQLite
│
├── domain/                     # Tầng nghiệp vụ (Domain Layer)
│   ├── entities/               # Entity thuần (business model)
│   ├── repositories/           # Abstract repository interface
│   └── usecases/               # Logic nghiệp vụ (LoginUser, GetProducts)
│
├── presentation/               # Tầng giao diện (Presentation Layer)
│   ├── pages/                  # Các màn hình (HomePage, LoginPage, ...)
│   ├── widgets/                # Các widget tái sử dụng
│   ├── blocs/                  # State management (Bloc, Cubit, Provider,...)
│   └── routes/                 # Điều hướng, định nghĩa route
│
├── injection_container.dart    # Khởi tạo dependency injection (GetIt, Riverpod...)
└── app.dart                    # Định nghĩa MaterialApp, navigator
```

---

##  **Cấu trúc Web (React + TypeScript)**

```
src/
│
├── domain/                        # Core business logic
│   ├── entities/                  # Định nghĩa các model / type chính
│   ├── repositories/              # Interface định nghĩa cách lấy dữ liệu (API, Local, etc.)
│   └── services/                  # Logic nghiệp vụ (pure functions, không phụ thuộc UI)
│
├── application/                   # ⚙️ Use Cases (Application logic)
│   ├── usecases/                  # Các hành động chính của user (fetchUser, updateProfile, ...)
│   ├── dto/                       # Data Transfer Object giữa domain <-> UI
│   └── mappers/                   # Chuyển đổi dữ liệu giữa tầng domain & UI
│
├── infrastructure/                # Implementation chi tiết
│   ├── api/                       # Gọi HTTP (axios/fetch)
│   ├── repositories/              # Triển khai interface repository (UserRepositoryImpl, ...)
│   ├── services/                  # Dịch vụ phụ: localStorage, Firebase, Supabase...
│   └── config/                    # Env, constants, setup, ...
│
├── presentation/                  # UI Layer
│   ├── components/                # Component UI thuần (Button, Modal, ...)
│   ├── pages/                     # Trang (Home, Login, Dashboard, ...)
│   ├── hooks/                     # Custom hook (useAuth, useForm, useFetch...)
│   ├── routes/                    # Định nghĩa router
│   ├── layouts/                   # Template UI dùng lại
│   └── providers/                 # Context Provider (theme, auth, language...)
│
├── shared/                        # Code dùng chung
│   ├── utils/                     # Hàm tiện ích (formatDate, debounce, ...)
│   ├── constants/                 # Hằng số toàn cục
│   ├── types/                     # TypeScript types toàn cục
│   └── styles/                    # Global CSS, theme, Tailwind config
│
└── index.tsx / main.tsx           # Entry point khởi tạo ứng dụng
```

---

## Nguyên tắc thiết kế

* **Tách biệt rõ tầng:** UI – Logic – Dữ liệu – Domain.
* **Dễ mở rộng:** Thêm chức năng mới chỉ cần tạo usecase & repository tương ứng.
* **Dễ test:** Có thể mock tầng domain hoặc data để test logic độc lập.
* **Dễ maintain:** Mỗi phần chỉ chịu trách nhiệm một nhiệm vụ (Single Responsibility Principle).

---

##  Gợi ý thư viện nên dùng

### Flutter

* **State management:** Bloc / Riverpod / Provider
* **DI:** GetIt
* **Networking:** Dio
* **Routing:** go_router

### React

* **State management:** React Query
* **Routing:** React Router v6
* **UI Framework:** TailwindCSS / Shadcn / Chakra UI
* **Networking:** Axios / TanStack Query

---

