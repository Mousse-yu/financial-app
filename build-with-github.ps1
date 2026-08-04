# 理财助手 - GitHub Actions 自动构建
# PowerShell脚本

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "理财助手 - GitHub Actions 自动构建" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# 检查Git安装
Write-Host "[1/4] 检查Git安装..." -ForegroundColor Yellow
try {
    $gitVersion = git --version
    Write-Host "✅ Git已安装: $gitVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ 错误: Git未安装" -ForegroundColor Red
    Write-Host "请先安装Git: https://git-scm.com/download/win" -ForegroundColor Yellow
    Read-Host "按Enter键退出"
    exit 1
}

# 配置Git
Write-Host "[2/4] 配置Git用户信息..." -ForegroundColor Yellow
$gitUser = git config user.name
if ([string]::IsNullOrEmpty($gitUser)) {
    Write-Host "请输入Git用户名:" -NoNewline
    $GIT_USER = Read-Host
    git config user.name "$GIT_USER"

    Write-Host "请输入Git邮箱:" -NoNewline
    $GIT_EMAIL = Read-Host
    git config user.email "$GIT_EMAIL"
}
Write-Host "✅ Git配置完成" -ForegroundColor Green

# 初始化Git
Write-Host "[3/4] 初始化Git仓库..." -ForegroundColor Yellow
Set-Location D:\financial_app
if (-not (Test-Path .git)) {
    git init
    git add .
    git commit -m "Initial commit: 理财助手"
    Write-Host "✅ 仓库初始化完成" -ForegroundColor Green
} else {
    Write-Host "✅ Git仓库已存在" -ForegroundColor Green
}

# 连接到GitHub
Write-Host "[4/4] 连接到GitHub..." -ForegroundColor Yellow
Write-Host "请选择:"
Write-Host "  1. 创建新仓库并推送"
Write-Host "  2. 推送到已存在的仓库"
Write-Host "  3. 取消"
$CHOICE = Read-Host "请输入选项 (1-3)"

if ($CHOICE -eq "1") {
    Write-Host ""
    Write-Host "[创建新仓库]" -ForegroundColor Yellow
    Write-Host "请输入仓库名称 (如: financial-app):" -NoNewline
    $REPO_NAME = Read-Host

    $GITHUB_URL = "https://github.com/$GIT_USER/$REPO_NAME.git"
    git remote add origin $GITHUB_URL
    git branch -M main
    git push -u origin main
    Write-Host ""
    Write-Host "✅ 代码已推送到GitHub!" -ForegroundColor Green
    Write-Host "✅ 请访问 https://github.com/$GIT_USER/$REPO_NAME/actions 查看构建进度" -ForegroundColor Green
} elseif ($CHOICE -eq "2") {
    Write-Host ""
    Write-Host "[推送到现有仓库]" -ForegroundColor Yellow
    Write-Host "请输入GitHub仓库URL (https://github.com/用户名/仓库名.git):" -NoNewline
    $GITHUB_URL = Read-Host
    git remote add origin $GITHUB_URL
    git push -u origin main
    Write-Host ""
    Write-Host "✅ 代码已推送到GitHub!" -ForegroundColor Green
    Write-Host "✅ 请访问 Actions 页面查看构建进度" -ForegroundColor Green
} else {
    Write-Host ""
    Write-Host "❌ 已取消" -ForegroundColor Red
    exit 0
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "推送到完成!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "下一步:" -ForegroundColor Yellow
Write-Host "1. 访问 https://github.com/$GIT_USER/$REPO_NAME/actions"
Write-Host "2. 点击 Build APK workflow"
Write-Host "3. 点击 Run workflow"
Write-Host "4. 选择分支，点击运行"
Write-Host "5. 等待构建完成（约2-3分钟）"
Write-Host "6. 下载 app-release.apk 到手机安装"
Write-Host ""

Read-Host "按Enter键退出"
