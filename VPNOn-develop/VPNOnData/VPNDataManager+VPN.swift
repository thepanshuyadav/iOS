//
//  VPNDataManager+VPN.swift
//  VPN On
//
//  Created by Lex Tang on 12/5/14.
//  Copyright (c) 2017 lexrus.com. All rights reserved.
//

import CoreData
import VPNOnKit

extension VPNDataManager {

    func allVPN() -> [VPN] {
        var vpns = [VPN]()
        
        let request = NSFetchRequest<VPN>(entityName: "VPN")
        let sortByTitle = NSSortDescriptor(key: "title", ascending: true)
        let sortByServer = NSSortDescriptor(key: "server", ascending: true)
        let sortByType = NSSortDescriptor(key: "ikev2", ascending: false)
        request.sortDescriptors = [sortByTitle, sortByServer, sortByType]
        
        if let moc = managedObjectContext, let results = (try? moc.fetch(request)) {
            results.forEach {
                if !$0.isDeleted {
                    vpns.append($0)
                }
            }
        }
        return vpns
    }
    
    func createVPN(
        _ title: String,
        server: String,
        account: String,
        password: String,
        group: String,
        secret: String,
        alwaysOn: Bool = true,
        ikev2: Bool = false,
        remoteID: String? = nil
        ) -> VPN?
    {
        guard
            let entity = NSEntityDescription.entity(forEntityName: "VPN", in: managedObjectContext!),
            let vpn = NSManagedObject(entity: entity, insertInto: managedObjectContext!) as? VPN
        else { return nil }
        
        vpn.title = title
        vpn.server = server
        vpn.account = account
        vpn.group = group
        vpn.alwaysOn = alwaysOn
        vpn.ikev2 = ikev2
        vpn.remoteID = remoteID
        
        do {
            try managedObjectContext!.save()
            saveContext()
            
            if !vpn.objectID.isTemporaryID {
                KeychainWrapper.setPassword(password, forVPNID: vpn.ID)
                if !secret.isEmpty {
                    KeychainWrapper.setSecret(secret, forVPNID: vpn.ID)
                }
                
                if allVPN().count == 1 {
                    VPNManager.shared.activatedVPNID = vpn.ID
                }
                return vpn
            }
        } catch {
            print("Could not save VPN \(error.localizedDescription)")
        }
        
        return nil
    }
    
    func deleteVPN(_ vpn:VPN) {
        let ID = "\(vpn.ID)"
        
        KeychainWrapper.destoryKeyForVPNID(ID)
        managedObjectContext!.delete(vpn)
        
        do {
            try managedObjectContext!.save()
        } catch { }
        saveContext()
        
        if VPNManager.shared.activatedVPNID == ID {
            VPNManager.shared.activatedVPNID = nil
            
            let vpns = allVPN()
            
            if let firstVPN = vpns.first {
                VPNManager.shared.activatedVPNID = firstVPN.ID
            }
        }
    }
    
    func VPNByID(_ ID: NSManagedObjectID) -> VPN? {
        if ID.isTemporaryID {
            return .none
        }
        
        var result: NSManagedObject?
        do {
            result = try managedObjectContext?.existingObject(with: ID)
        } catch { }

        if let vpn = result as? VPN, !vpn.isDeleted {
            managedObjectContext?.refresh(vpn, mergeChanges: true)
            return vpn
        }
        return nil
    }
    
    func VPNByIDString(_ ID: String) -> VPN? {
        guard let URL = URL(string: ID) else { return nil }
        if URL.scheme?.lowercased() == "x-coredata" {
            if let moid = persistentStoreCoordinator!.managedObjectID(forURIRepresentation: URL) {
                return VPNByID(moid)
            }
        }
        return nil
    }
    
    func VPNByPredicate(_ predicate: NSPredicate) -> [VPN] {
        var vpns = [VPN]()
        let request = NSFetchRequest<VPN>(entityName: "VPN")
        request.predicate = predicate
        
        guard let results = try? managedObjectContext!.fetch(request) else { return vpns }
        
        results.filter { !$0.isDeleted }.forEach { vpns.append($0) }
        
        return vpns
    }
    
    func VPNBeginsWithTitle(_ title: String) -> [VPN] {
        let titleBeginsWithPredicate = NSPredicate(format: "title beginswith[cd] %@", argumentArray: [title])
        return VPNByPredicate(titleBeginsWithPredicate)
    }
    
    func VPNHasTitle(_ title: String) -> [VPN] {
        let titleBeginsWithPredicate = NSPredicate(format: "title == %@", argumentArray: [title])
        return VPNByPredicate(titleBeginsWithPredicate)
    }
    
    func duplicate(_ vpn: VPN) -> VPN? {
        let duplicatedVPNs = VPNDataManager.shared.VPNBeginsWithTitle(vpn.title)
        if duplicatedVPNs.count > 0 {
            guard let title = vpn.title else { return nil }
            let newTitle = "\(title) \(duplicatedVPNs.count)"

            if let newVPN = createVPN(
                newTitle,
                server: vpn.server,
                account: vpn.account,
                password: KeychainWrapper.passwordStringForVPNID(vpn.ID) ?? "",
                group: vpn.group,
                secret: KeychainWrapper.secretStringForVPNID(vpn.ID) ?? "",
                alwaysOn: vpn.alwaysOn,
                ikev2: vpn.ikev2,
                remoteID: vpn.remoteID
                ) {
                    if let password = KeychainWrapper.passwordStringForVPNID(vpn.ID) {
                        KeychainWrapper.setPassword(password, forVPNID: newVPN.ID)
                    }
                    if let secret = KeychainWrapper.secretStringForVPNID(vpn.ID) {
                        KeychainWrapper.setSecret(secret, forVPNID: newVPN.ID)
                    }

                    return newVPN
            }
        }
        
        return nil
    }
}
