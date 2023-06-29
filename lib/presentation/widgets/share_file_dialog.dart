import 'package:flutter/material.dart';
import 'package:goal_lock/domain/usecases/files/copy_file_url_to_clipboard_usecase.dart';

import '../../domain/entities/file_from_server_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/files/update_file_visibility_usecase.dart';
import '../../injection_container.dart';

class ShareFileDialog extends StatefulWidget {
  ShareFileDialog({
    super.key,
    required this.file,
    required this.userEntity,
  });

  final FileFromServerEntity file;
  final UserEntity userEntity;
  @override
  State<ShareFileDialog> createState() => _ShareFileDialogState();
}

class _ShareFileDialogState extends State<ShareFileDialog> {
  bool copied = false;
  @override
  Widget build(BuildContext context) {
    bool initialFilePrivateSatusvalue = widget.file.sharable;
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Color(0xff17181F).withOpacity(0.7),
        elevation: 5,
        child: Container(
          height: 230,
          width: 250,
          decoration: BoxDecoration(
              // color: Color(0xff17181F),
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: const Text(
                  'Your Sharable Url',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 20,
                  ),
                ),
              ),
              Container(
                height: 50,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blueGrey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.white70),
                ),
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                child: Text(
                  widget.file.sharable_url,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white70),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Private',
                        style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                            fontWeight: FontWeight.w500)),
                    Switch(
                      value: !initialFilePrivateSatusvalue,
                      //TODO update the value of file visibility in list
                      onChanged: (value) {
                        setState(() {
                          widget.file.sharable = !value;
                          sl<UpdateFileVisibiityusecase>().call(
                              email: widget.userEntity.email,
                              fileName: widget.file.name,
                              value: widget.file.sharable.toString());
                        });
                      },
                      inactiveTrackColor: Colors.blueGrey.withOpacity(0.5),
                      activeTrackColor: Colors.blueGrey,
                      activeColor: Colors.white30,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  sl<CopyFileUrlToClipBoard>().call(widget.file.sharable_url);
                  setState(() {
                    copied = true;
                  });
                },
                child: AnimatedContainer(
                    height: 40,
                    width: copied ? 80 : 60,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: copied
                            ? Colors.green.withOpacity(0.2)
                            : Colors.blueAccent.withOpacity(0.2),
                        border: Border.all(color: Colors.white70)),
                    alignment: Alignment.center,
                    duration: Duration(milliseconds: 200),
                    child: Text(
                      copied ? 'Copied' : 'Copy',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                      // style: ButtonStyle(
                      //   backgroundColor: MaterialStateProperty.all(
                      //       Colors.blueGrey.withOpacity(0.3)),
                      //   shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(20))),
                      //   padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                      //   foregroundColor: MaterialStateProperty.all(Colors.white70),
                      //   enableFeedback: true,
                      // ),
                    )),
              )
            ],
          ),
        ));
  }
}
