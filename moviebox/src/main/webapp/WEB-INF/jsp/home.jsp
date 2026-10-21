<%@ page pageEncoding="UTF-8" %>
<%@ include file="_head.jsp" %>
<main>
  <p class="muted">Welcome back, <c:out value="${user.fname}"/>. Rate and review the films you've watched.</p>

  <c:if test="${not configured}">
    <div class="note" style="margin-top:16px">Movie data is off. Add <b>tmdb.api.key</b> to application.properties (free key from themoviedb.org) and restart.</div>
  </c:if>

  <h2>
    <c:choose>
      <c:when test="${not empty q}">Results for "<c:out value="${q}"/>"</c:when>
      <c:otherwise>Popular right now</c:otherwise>
    </c:choose>
  </h2>

  <div class="grid">
    <c:forEach var="m" items="${movies}">
      <a class="poster" href="/movies/${m.id}">
        <c:choose>
          <c:when test="${not empty m.poster}"><img src="${m.poster}" alt="<c:out value='${m.title}'/>"></c:when>
          <c:otherwise><div class="noimg"><c:out value="${m.title}"/></div></c:otherwise>
        </c:choose>
        <div class="meta">
          <c:out value="${m.title}"/>
          <c:if test="${not empty m.avg}"><br><span class="stars">★</span> ${m.avg}</c:if>
        </div>
      </a>
    </c:forEach>
  </div>
  <c:if test="${empty movies and configured}"><p class="muted">No films found.</p></c:if>

  <c:if test="${empty q and not empty recent}">
    <h2>Recent reviews</h2>
    <div class="reviews">
      <c:forEach var="r" items="${recent}">
        <div class="review">
          <c:if test="${not empty r.posterUrl}"><a href="/movies/${r.tmdbId}"><img src="${r.posterUrl}" alt=""></a></c:if>
          <div>
            <a href="/movies/${r.tmdbId}"><b><c:out value="${r.movieTitle}"/></b></a>
            <span class="stars">${r.stars}</span>
            <small class="muted">by <c:out value="${r.userName}"/> · ${r.dateLabel}</small>
            <p><c:out value="${r.body}"/></p>
          </div>
        </div>
      </c:forEach>
    </div>
  </c:if>
</main>
</body>
</html>
