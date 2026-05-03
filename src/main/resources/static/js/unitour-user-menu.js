(() => {
  function escapeHtml(value) {
    return String(value ?? "")
      .replaceAll("&", "&amp;")
      .replaceAll("<", "&lt;")
      .replaceAll(">", "&gt;")
      .replaceAll('"', "&quot;")
      .replaceAll("'", "&#039;");
  }

  function redirectParam() {
    return encodeURIComponent(`${location.pathname}${location.search}${location.hash}`);
  }

  function activeClass(paths) {
    return paths.includes(location.pathname) ? " class=\"active\"" : "";
  }

  function renderNav(topbar) {
    let nav = topbar.querySelector(".nav");
    if (!nav) {
      nav = document.createElement("nav");
      nav.className = "nav";
      topbar.appendChild(nav);
    }
    nav.innerHTML = `
      <a${activeClass(["/", "/index.html"])} href="/index.html">首页</a>
      <a${activeClass(["/universities.html", "/university-detail.html"])} href="/universities.html">高校库</a>
      <a${activeClass(["/campus-pois.html"])} href="/campus-pois.html">POI</a>
    `;
  }

  function renderMenu(container, user, loggedIn) {
    const name = user?.nickname || user?.username || "用户";
    const initial = loggedIn ? name.slice(0, 1).toUpperCase() : "U";
    container.innerHTML = `
      <div class="user-menu">
        <button class="avatar-btn" id="userMenuBtn" type="button" aria-label="打开用户菜单" aria-expanded="false">
          ${loggedIn && user?.avatarUrl ? `<img src="${escapeHtml(user.avatarUrl)}" alt="">` : `<span>${escapeHtml(initial)}</span>`}
        </button>
        <div class="user-dropdown" id="userDropdown">
          <a href="/user-center.html">用户中心</a>
          ${loggedIn
            ? `<button id="logoutMenuBtn" type="button">退出登录</button>`
            : `<a href="/auth-center.html?redirect=${redirectParam()}">登录/注册</a>`}
        </div>
      </div>
    `;

    const menu = container.querySelector("#userDropdown");
    const button = container.querySelector("#userMenuBtn");
    button.addEventListener("click", (event) => {
      event.stopPropagation();
      menu.classList.toggle("show");
      button.setAttribute("aria-expanded", String(menu.classList.contains("show")));
    });
    menu.addEventListener("click", (event) => event.stopPropagation());
    const logout = container.querySelector("#logoutMenuBtn");
    if (logout) {
      logout.addEventListener("click", () => {
        UniTour.setToken("");
        window.dispatchEvent(new CustomEvent("unitour:logout"));
        if (location.pathname === "/user-center.html") {
          location.reload();
          return;
        }
        renderMenu(container, null, false);
      });
    }
    document.addEventListener("click", () => {
      menu.classList.remove("show");
      button.setAttribute("aria-expanded", "false");
    });
  }

  async function boot() {
    const topbar = document.querySelector(".topbar-inner");
    if (!topbar || typeof UniTour === "undefined") return;
    renderNav(topbar);

    const container = document.createElement("div");
    container.className = "user-slot";
    topbar.appendChild(container);

    if (!UniTour.token()) {
      renderMenu(container, null, false);
      return;
    }

    renderMenu(container, null, true);
    try {
      const user = await UniTour.me();
      renderMenu(container, user, true);
    } catch {
      UniTour.setToken("");
      renderMenu(container, null, false);
    }

    window.addEventListener("unitour:user-updated", (event) => {
      if (UniTour.token()) {
        renderMenu(container, event.detail, true);
      }
    });
  }

  boot();
})();
