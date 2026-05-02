const UniTour = (() => {
  const API_PREFIX = "/api/v1";

  function token() {
    return localStorage.getItem("unitour_token") || "";
  }

  function setToken(value) {
    if (value) {
      localStorage.setItem("unitour_token", value);
    } else {
      localStorage.removeItem("unitour_token");
    }
  }

  function authHeaders() {
    const value = token();
    return value ? { Authorization: `Bearer ${value}` } : {};
  }

  function query(params) {
    const search = new URLSearchParams();
    Object.entries(params || {}).forEach(([key, value]) => {
      if (value !== undefined && value !== null && value !== "") {
        search.set(key, value);
      }
    });
    const text = search.toString();
    return text ? `?${text}` : "";
  }

  async function request(path, options = {}) {
    const headers = {
      Accept: "application/json",
      ...authHeaders(),
      ...(options.headers || {})
    };

    if (options.body && !headers["Content-Type"]) {
      headers["Content-Type"] = "application/json";
    }

    const response = await fetch(`${API_PREFIX}${path}`, {
      ...options,
      headers,
      body: options.body && typeof options.body !== "string" ? JSON.stringify(options.body) : options.body
    });

    const payload = await response.json().catch(() => null);
    if (!response.ok) {
      throw new Error(`HTTP ${response.status}`);
    }
    if (payload && payload.code === 0) {
      throw new Error(payload.msg || "请求失败");
    }
    return payload ? payload.data : null;
  }

  function listUniversities(params = {}) {
    return request(`/universities${query(params)}`);
  }

  function universityDetail(id) {
    return request(`/universities/${id}`);
  }

  function campusPois(campusId) {
    return request(`/campuses/${campusId}/pois`);
  }

  function reviews(universityId, params = {}) {
    return request(`/universities/${universityId}/reviews${query(params)}`);
  }

  function createReview(universityId, body) {
    return request(`/universities/${universityId}/reviews`, { method: "POST", body });
  }

  function createReply(reviewId, body) {
    return request(`/reviews/${reviewId}/replies`, { method: "POST", body });
  }

  function likeReview(reviewId) {
    return request(`/reviews/${reviewId}/likes`, { method: "POST" });
  }

  function unlikeReview(reviewId) {
    return request(`/reviews/${reviewId}/likes`, { method: "DELETE" });
  }

  function login(body) {
    return request("/auth/login", { method: "POST", body });
  }

  function register(body) {
    return request("/auth/register", { method: "POST", body });
  }

  function me() {
    return request("/users/me");
  }

  function updateProfile(body) {
    return request("/users/me/profile", { method: "PUT", body });
  }

  function qs(name) {
    return new URLSearchParams(location.search).get(name);
  }

  function formatScore(value) {
    if (value === null || value === undefined || value === "") return "-";
    const num = Number(value);
    if (Number.isNaN(num)) return value;
    return num.toFixed(1);
  }

  function escapeHtml(value) {
    return String(value ?? "")
      .replaceAll("&", "&amp;")
      .replaceAll("<", "&lt;")
      .replaceAll(">", "&gt;")
      .replaceAll('"', "&quot;")
      .replaceAll("'", "&#039;");
  }

  function tags(value) {
    return String(value || "")
      .split(",")
      .map((item) => item.trim())
      .filter(Boolean);
  }

  function categoryName(value) {
    const map = {
      1: "景观活动",
      2: "教学科研",
      3: "生活餐饮",
      4: "体育运动"
    };
    return map[value] || "校园点位";
  }

  function categoryIcon(value) {
    const map = {
      1: "景",
      2: "学",
      3: "生",
      4: "体"
    };
    return map[value] || "点";
  }

  return {
    request,
    listUniversities,
    universityDetail,
    campusPois,
    reviews,
    createReview,
    createReply,
    likeReview,
    unlikeReview,
    login,
    register,
    me,
    updateProfile,
    token,
    setToken,
    qs,
    formatScore,
    escapeHtml,
    tags,
    categoryName,
    categoryIcon
  };
})();
