#!/usr/bin/env python
import argparse
import os
import requests

def PathChecker(v):
    if os.path.exists(v):
        return v
    else:
        raise argparse.ArgumentTypeError("Given value '%s' is not a valid path."%(v,))


def TokenChecker(v):
    if len(v) == 40:
        return v
    else:
        raise argparse.ArgumentTypeError("Invalid Token Length")


def TokenTest(parser, args):
    headers = {'Authorization': 'Token %s' % (args.token,)}
    test_path = args.host + "/i/api/"
    r = requests.get(test_path, headers=headers)
    r_json = r.json()
    if r.status_code == 401:
        raise parser.error(r_json['detail'])



if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Upload an image to an iGNG server', prog="iGNG Uploader")
    parser.add_argument("--host", help="Select a different host", default="http://i.gng.io")
    #parser.add_argument("--host", help="Select a different host", default="http://localhost:8000")
    parser.add_argument("--path", type=PathChecker, help="Folder/File to upload", required=True)
    parser.add_argument("--gallery", help="Gallery (created if missing / if none selected, using default)")
    parser.add_argument("--token", help="Authentication Token", required=True)
    args = parser.parse_args()

    # try auth
    TokenTest(parser, args)

    target_host = args.host
    target_headers = {'Authorization': 'Token %s' % (args.token,)}

    # get galleries, create if necessary

    if not args.gallery:
        gallery_resp = requests.get(target_host + "/i/api/user/gallery/default/", headers=target_headers)
        gal_json = gallery_resp.json()
        gal_uuid = gal_json['uuid']

    else:
        gallery_resp = requests.get(target_host + "/i/api/user/gallery/", headers=target_headers)
        gal_json = gallery_resp.json()
        gal_avail = {i['title']:i['uuid'] for i in gal_json}

        if args.gallery in gal_avail.keys():
            gal_uuid = gal_avail[args.gallery]

        else:
            # create new
            gal_resp = requests.post(target_host + "/i/api/user/gallery/", headers=target_headers, data={"title":args.gallery, "private":True})
            if gal_resp.status_code == 201:
                gal_json = gal_resp.json()
                gal_uuid = gal_json['uuid']

            else:
                print gal_resp.text
                raise


    # begin upload
    if os.path.isdir(args.path):
        all_files = os.listdir(args.path)
        image_files = [img for img in all_files if img.rsplit('.',1)[1].lower() in ['jpg','gif','png']]
        total_count = len(image_files)
        print "Uploading %i" % total_count

        count = 0
        for i in image_files:
            f = open("%s/%s" % (args.path, i),'rb')
            files = {"original":f}
            gal_resp = requests.post(target_host + "/i/api/user/gallery/%s/upload/" % (gal_uuid,), headers=target_headers, files=files)
            if gal_resp.status_code == 201:
                count +=1
                print "%i/%i Uploaded" % (count, total_count)
            else:
                print "Upload Fail for %s" % i
        # handle dir
    else:
        f = open(args.path,'rb')
        files = {"original":f}
        gal_resp = requests.post(target_host + "/i/api/user/gallery/%s/upload/" % (gal_uuid,), headers=target_headers, files=files)
        if gal_resp.status_code == 201:
            print "Single Image Uploaded!"
        else:
            print "Upload Fail for %s" % args.path


