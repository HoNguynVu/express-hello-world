# Sử dụng image Node.js phiên bản nhỏ gọn (alpine) làm base image
FROM node:18-alpine

# Thiết lập thư mục làm việc mặc định trong container
WORKDIR /app

# Sao chép package.json và yarn.lock vào container để tận dụng Docker cache
COPY package.json yarn.lock ./

# Cài đặt các dependencies bằng yarn dựa trên cấu hình giống với Render
RUN yarn install --frozen-lockfile

# Sao chép toàn bộ mã nguồn còn lại vào container
COPY . .

# Thiết lập các biến môi trường
ENV NODE_ENV=production
ENV PORT=3001

# Khai báo port mà ứng dụng sẽ lắng nghe
EXPOSE 3001

# Lệnh khởi chạy ứng dụng
CMD ["node", "app.js"]