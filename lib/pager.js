
var Pager;

Pager = (function() {
  function Pager(items, itemsPerPage) {
    if (itemsPerPage == null) {
      itemsPerPage = 5;
    }
    this.items = items;
    this.itemsPerPage = itemsPerPage;
    this.page = 1;
    this.pages = Math.floor((this.items.length - 1) / this.itemsPerPage) + 1;
  }

  Pager.prototype.currentPageItems = function() {
    return this.items.filter((function(_this) {
      return function(_, i) {
        return ((_this.page - 1) * _this.itemsPerPage <= i) && (i < _this.page * _this.itemsPerPage);
      };
    })(this));
  };

  Pager.prototype.next = function() {
    return this.page += 1;
  };

  Pager.prototype.hasNext = function() {
    return this.page <= this.pages;
  };

  return Pager;

})();

module.exports.Pager = Pager;
