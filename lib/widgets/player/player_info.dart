import 'package:Wellness/model/player.dart';
import 'package:Wellness/services/app_localizations.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../badge_field.dart';

class PlayerInfo extends StatelessWidget {
  final Player player;

  PlayerInfo(this.player);

  @override
  Widget build(BuildContext context) {
    var team = EnumToString.parseCamelCase(player.team).split(" ");
    var teamName = AppLoc.getValue(team[0].toLowerCase());
    if (team.length > 1) {
      teamName = "$teamName ${team[1]}";
    }

    return new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Text(
          player.name,
          style: Theme.of(context)
              .textTheme
              .headline
              .copyWith(color: Colors.white),
        ),
        new Padding(
          padding: const EdgeInsets.only(top: 10),
        ),
        Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                new Padding(
                  child: BadgeField(
                    teamName,
                    Padding(
                      padding: EdgeInsets.all(3),
                      child: SvgPicture.asset(
                        "assets/teams.svg",
                        color: Colors.white,
                        width: 100,
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.only(right: 5, left: 5),
                ),
                new Padding(
                  child: BadgeField(
                    AppLoc.getValue(
                      EnumToString.parse(player.dominantMember),
                    ),
                    Padding(
                      padding: EdgeInsets.all(4),
                      child: SvgPicture.asset(
                        "assets/leg.svg",
                        color: Colors.white,
                        width: 100,
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.only(right: 5, left: 5),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 0),
              child: Row(
                children: <Widget>[
                  new Padding(
                    child: BadgeField(
                      "${player.height} cm",
                      Icon(MdiIcons.humanMaleHeightVariant,
                          color: Colors.white, size: 20),
                    ),
                    padding: const EdgeInsets.only(right: 5, left: 5),
                  ),
                  new Padding(
                    child: BadgeField(
                      "${player.weight} kg",
                      Icon(MdiIcons.weightKilogram,
                          color: Colors.white, size: 20),
                    ),
                    padding: const EdgeInsets.only(right: 5, left: 5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
