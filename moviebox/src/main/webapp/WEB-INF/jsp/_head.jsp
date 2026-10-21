<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Movieboxd</title>
<style>
*{box-sizing:border-box;margin:0;padding:0}
body{background:#121212;color:#f5f5f5;font-family:'Poppins',Arial,sans-serif;line-height:1.5}
a{color:inherit;text-decoration:none}
.nav{display:flex;align-items:center;gap:20px;flex-wrap:wrap;padding:14px 5%;background:#181818;border-bottom:1px solid #2a2a2a;position:sticky;top:0;z-index:5}
.brand{font-weight:700;font-size:1.3rem;color:#00b894}
.search{flex:1;min-width:160px}
.search input{width:100%;max-width:360px;padding:8px 12px;border-radius:6px;border:1px solid #333;background:#222;color:#fff}
.links{display:flex;gap:16px;color:#bbb}
.links a:hover{color:#fff}
main{max-width:1100px;margin:0 auto;padding:24px 5%}
h2{font-size:1rem;margin:28px 0 12px;color:#9ab;text-transform:uppercase;letter-spacing:1px}
.grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(150px,1fr));gap:16px}
.poster{position:relative;display:block;aspect-ratio:2/3;background:#222;border-radius:6px;overflow:hidden;border:2px solid transparent}
.poster:hover{border-color:#00b894}
.poster img{width:100%;height:100%;object-fit:cover}
.poster .meta{position:absolute;left:0;right:0;bottom:0;padding:22px 8px 8px;background:linear-gradient(transparent,rgba(0,0,0,.9));font-size:.8rem}
.noimg{display:flex;align-items:center;justify-content:center;height:100%;padding:8px;text-align:center;color:#888}
.stars{color:#00b894;letter-spacing:2px}
.flash{max-width:1100px;margin:14px auto;padding:10px 14px;border-radius:6px}
.ok{background:#12372f;color:#7fe9c9}
.err{background:#3a1717;color:#ff9a9a}
.note{background:#2b2616;color:#f0d68a;padding:12px 14px;border-radius:6px;margin-bottom:16px}
.reviews{display:grid;gap:14px}
.review{display:flex;gap:14px;background:#1c1c1c;padding:14px;border-radius:8px}
.review img{width:56px;height:84px;object-fit:cover;border-radius:4px}
.review p{margin-top:4px;word-break:break-word}
.hero{display:flex;gap:28px;flex-wrap:wrap}
.hero img{width:240px;border-radius:8px;align-self:flex-start}
.hero .info{flex:1;min-width:260px}
.hero h1{font-size:1.8rem}
.muted{color:#999}
.form{background:#1c1c1c;padding:16px;border-radius:8px;margin:22px 0}
.form textarea{width:100%;min-height:90px;margin:10px 0;padding:10px;border-radius:6px;border:1px solid #333;background:#222;color:#fff;font:inherit}
.btn{background:#00b894;color:#fff;border:0;border-radius:6px;padding:9px 18px;cursor:pointer;font:inherit}
.btn.del{background:#444}
.star-input{display:inline-flex;flex-direction:row-reverse;gap:4px;margin-top:8px}
.star-input input{display:none}
.star-input label{font-size:2rem;color:#444;cursor:pointer;line-height:1}
.star-input input:checked~label,.star-input label:hover,.star-input label:hover~label{color:#00b894}
</style>
</head>
<body>
<nav class="nav">
  <a class="brand" href="/home">Movieboxd</a>
  <form action="/home" method="get" class="search">
    <input type="search" name="q" value="<c:out value='${param.q}'/>" placeholder="Search films">
  </form>
  <div class="links">
    <a href="/home">Films</a>
    <a href="/profile">My diary</a>
    <a href="/logout">Logout</a>
  </div>
</nav>
<c:if test="${not empty message}"><div class="flash ok"><c:out value="${message}"/></div></c:if>
<c:if test="${not empty error}"><div class="flash err"><c:out value="${error}"/></div></c:if>
