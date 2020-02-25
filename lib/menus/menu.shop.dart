import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerShop extends StatefulWidget {
  TabController _tabController;

  DrawerShop(this._tabController);

  @override
  _DrawerShopState createState() => _DrawerShopState(this._tabController);
}

class _DrawerShopState extends State<DrawerShop> {
  TabController _tabController;

  _DrawerShopState(this._tabController);

  @override
  Widget build(BuildContext context) {
    MenuItem _loja = MenuItem("Loja", "Catálogo de cartazes", FontAwesomeIcons.shoppingCart);
    MenuItem _pedidos = MenuItem("Pedidos", "Status de pedidos", FontAwesomeIcons.wallet);
    MenuItem _pagamento = MenuItem("Pagamento", "Informações de pagamento", Icons.credit_card);
    MenuItem _indique = MenuItem("Indique e Ganhe", "Seu código e seus ganhos", FontAwesomeIcons.tag);

    List<MenuItem> menu_items = [_loja, _pedidos, _pagamento, _indique];

    return Drawer(
      child: Container(
        padding: EdgeInsets.only(top: 50),
        color: Color.fromRGBO(25, 26, 31, 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Wrap(
                children: menu_items.map((menuItem){
                  return FlatButton(
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      setState(() {
                        _tabController.animateTo(menu_items.indexOf(menuItem));
                        Navigator.pop(context);
                      });
                    },
                    color: menu_items.indexOf(menuItem) == _tabController.index ? Colors.black38 : Colors.transparent,
                    child: ListTile(
                      dense: true,
                      trailing: Icon(
                        Icons.arrow_right,
                        color: Colors.grey,
                      ),
                      leading: Icon(
                        menuItem.icon,
                        color: Colors.purple,
                      ),
                      title: Text(
                        menuItem.title.toUpperCase(),
                        style: TextStyle(color: Colors.grey),
                      ),
                      subtitle: Text(
                        menuItem.subtitle,
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                  );
                }).toList()
            ),
            Column(
              children: <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () {},
                        elevation: 0,
                        color: Color.fromRGBO(25, 26, 31, 1),
                        child: Icon(
                          FontAwesomeIcons.facebookF,
                          color: Colors.grey,
                        ),
                      ),
                      RaisedButton(
                        onPressed: () {},
                        elevation: 0,
                        color: Color.fromRGBO(25, 26, 31, 1),
                        child: Icon(
                          FontAwesomeIcons.instagram,
                          color: Colors.grey,
                        ),
                      ),
                      RaisedButton(
                        onPressed: () {},
                        elevation: 0,
                        color: Color.fromRGBO(25, 26, 31, 1),
                        child: Icon(
                          FontAwesomeIcons.whatsapp,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                ),
                RaisedButton(
                    padding: EdgeInsets.all(0),
                    onPressed: () {},
                    elevation: 0,
                    color: Color.fromRGBO(25, 26, 31, 1),
                    child: Text("Sobre nós", style: TextStyle(color: Colors.grey)))
              ],
            )
          ],
        ),
      ),
    );
  }
}


class MenuItem{
  String title;
  String subtitle;
  IconData icon;

  MenuItem(this.title, this.subtitle, this.icon);
}